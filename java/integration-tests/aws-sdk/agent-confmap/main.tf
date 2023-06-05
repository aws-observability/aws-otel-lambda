data "aws_region" "current" {}

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
  collector_config_layer_arn = aws_lambda_layer_version.collector_config_layer.arn
  tracing_mode               = var.tracing_mode
}

resource "aws_iam_role_policy_attachment" "hello-lambda-cloudwatch-insights" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_prometheus_workspace" "test_amp_workspace" {
  alias = var.function_name
  tags = {"ephemeral" = "true"}
}

locals {
  // We have to scape '"" because the containing string will be interpreted as yaml
  prw_content = <<EOT
auth:
  authenticator: sigv4auth
endpoint: "${aws_prometheus_workspace.test_amp_workspace.prometheus_endpoint}api/v1/remote_write"
EOT
}

resource "random_id" "test_id" {

  byte_length = 8
}

module "remote_configuration" {
  source = "../../../../terraform/remote_configuration"

  content = local.prw_content
  scheme = var.configuration_source
  testing_id = random_id.test_id.hex
}

data "archive_file" "init" {
  type       = "zip"
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
  prometheusremotewrite: $${${module.remote_configuration.configuration_uri}}


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

resource "aws_iam_role_policy_attachment" "test_confmap" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "test_amp" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusFullAccess"
}

resource "aws_lambda_layer_version" "collector_config_layer" {
  depends_on          = [data.archive_file.init]
  layer_name          = "custom-config-layer"
  filename            = "${path.module}/build/custom-config-layer.zip"
  compatible_runtimes = ["java8", "java8.al2", "java11"]
  license_info        = "Apache-2.0"
}
