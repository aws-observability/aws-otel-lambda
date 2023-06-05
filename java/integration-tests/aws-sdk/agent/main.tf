locals {
  architecture = var.architecture == "x86_64" ? "amd64" : "arm64"
}

resource "aws_lambda_layer_version" "sdk_layer" {
  layer_name          = var.sdk_layer_name
  filename            = "${path.module}/../../../../opentelemetry-lambda/java/layer-javaagent/build/distributions/opentelemetry-javaagent-layer.zip"
  compatible_runtimes = ["java8", "java8.al2", "java11"]
  license_info        = "Apache-2.0"
  source_code_hash    = filebase64sha256("${path.module}/../../../../opentelemetry-lambda/java/layer-javaagent/build/distributions/opentelemetry-javaagent-layer.zip")
}

resource "aws_lambda_layer_version" "collector_layer" {
  count               = var.enable_collector_layer ? 1 : 0
  layer_name          = var.collector_layer_name
  filename            = "${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip"
  compatible_runtimes = ["nodejs14.x", "nodejs16.x", "nodejs18.x"]
  license_info        = "Apache-2.0"
  source_code_hash    = filebase64sha256("${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip")
}

module "hello-lambda-function" {
  source                     = "../../../../opentelemetry-lambda/java/sample-apps/aws-sdk/deploy/agent"
  name                       = var.function_name
  architecture               = var.architecture
  collector_layer_arn        = var.enable_collector_layer ? aws_lambda_layer_version.collector_layer[0].arn : null
  sdk_layer_arn              = aws_lambda_layer_version.sdk_layer.arn
  collector_config_layer_arn = length(aws_lambda_layer_version.collector_config_layer) > 0 ? aws_lambda_layer_version.collector_config_layer[0].arn : null
  tracing_mode               = var.tracing_mode
}

resource "aws_iam_role_policy_attachment" "hello-lambda-cloudwatch-insights" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


data "aws_region" "current" {}

resource "aws_prometheus_workspace" "test_amp_workspace" {
  count = contains(["us-west-2", "us-east-1", "us-east-2", "eu-central-1", "eu-west-1"], data.aws_region.current.name) ? 1 : 0
  alias = var.function_name
  tags = {"ephemeral" = "true"}
}

data "archive_file" "init" {
  type       = "zip"
  count      = length(aws_prometheus_workspace.test_amp_workspace) > 0 ? 1 : 0
  depends_on = [aws_prometheus_workspace.test_amp_workspace, data.aws_region.current]
  source {
    content  = <<EOT
extensions:
  sigv4auth:
    region: ${data.aws_region.current.name}

receivers:
  otlp:
    protocols:
      grpc:
        endpoint: "localhost:4317"
      http:
        endpoint: "localhost:4318"
exporters:
  logging:
  awsxray:
  prometheusremotewrite:
    endpoint: "${aws_prometheus_workspace.test_amp_workspace[0].prometheus_endpoint}api/v1/remote_write"
    auth:
      authenticator: sigv4auth

service:
  extensions: [sigv4auth]
  pipelines:
    traces:
      receivers: [otlp]
      exporters: [awsxray]
    metrics:
      receivers: [otlp]
      exporters: [logging, prometheusremotewrite]
  telemetry:
    metrics:
      address: localhost:8888
EOT
    filename = "config.yaml"
  }

  output_path = "${path.module}/build/custom-config-layer.zip"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy_attachment" "test_amp" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusFullAccess"
}

resource "aws_lambda_layer_version" "collector_config_layer" {
  count               = length(data.archive_file.init) > 0 ? 1 : 0
  depends_on          = [data.archive_file.init]
  layer_name          = "custom-config-layer"
  filename            = "${path.module}/build/custom-config-layer.zip"
  compatible_runtimes = ["java8", "java8.al2", "java11"]
  license_info        = "Apache-2.0"
}
