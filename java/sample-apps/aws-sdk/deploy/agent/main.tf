data "aws_region" "current" {}

locals {
  architecture_to_arns_mapping = {
    "x86_64" = local.sdk_layer_arns_amd64
    "arm64"  = local.sdk_layer_arns_arm64
  }
}

module "app" {
  source = "../../../../../opentelemetry-lambda/java/sample-apps/aws-sdk/deploy/agent"

  name                       = var.function_name
  collector_layer_arn        = null
  runtime                    = var.runtime
  sdk_layer_arn              = local.architecture_to_arns_mapping[var.architecture][data.aws_region.current.name]
  collector_config_layer_arn = length(aws_lambda_layer_version.collector_config_layer) > 0 ? aws_lambda_layer_version.collector_config_layer[0].arn : null
  tracing_mode               = "Active"
  architecture               = var.architecture
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.app.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy_attachment" "test_amp" {
  role       = module.app.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusFullAccess"
}

resource "aws_prometheus_workspace" "test_amp_workspace" {
  count = contains(["us-west-2", "us-east-1", "us-east-2", "eu-central-1", "eu-west-1"], data.aws_region.current.name) ? 1 : 0
  alias = var.function_name
  tags = {"ephemeral" = "true"}
}

data "archive_file" "init" {
  type       = "zip"
  count      = length(aws_prometheus_workspace.test_amp_workspace) > 0 ? 1 : 0
  depends_on = [aws_prometheus_workspace.test_amp_workspace[0], data.aws_region.current]
  source {
    content  = <<EOT
extensions:
  sigv4auth:
    region: ${data.aws_region.current.name}

receivers:
  otlp:
    protocols:
      grpc:
      http:

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
EOT
    filename = "config.yaml"
  }

  output_path = "${path.module}/build/custom-config-layer.zip"
}

resource "aws_lambda_layer_version" "collector_config_layer" {
  count               = length(data.archive_file.init) > 0 ? 1 : 0
  depends_on          = [data.archive_file.init]
  layer_name          = "custom-config-layer"
  filename            = "${path.module}/build/custom-config-layer.zip"
  compatible_runtimes = ["java8.al2", "java11", "java17"]
  license_info        = "Apache-2.0"
}
