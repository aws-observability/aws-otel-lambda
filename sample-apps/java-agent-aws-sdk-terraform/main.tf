data "aws_region" "current" {}

module "app" {
  source = "../../opentelemetry-lambda/java/sample-apps/aws-sdk/deploy/agent"

  name                       = var.function_name
  collector_layer_arn        = null
  sdk_layer_arn              = lookup(local.sdk_layer_arns, data.aws_region.current.name, "invalid")
  collector_config_layer_arn = aws_lambda_layer_version.collector_config_layer.arn
  tracing_mode               = "Active"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.app.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy_attachment" "test_amp" {
  role       = module.app.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusFullAccess"
}

resource "aws_prometheus_workspace" "test_amp_workspace" {}

data "archive_file" "init" {
  type       = "zip"
  depends_on = [aws_prometheus_workspace.test_amp_workspace, data.aws_region.current]
  source {
    content  = <<EOT
receivers:
  otlp:
    protocols:
      grpc:
      http:

exporters:
  logging:
  awsxray:
  awsprometheusremotewrite:
    endpoint: "${aws_prometheus_workspace.test_amp_workspace.prometheus_endpoint}api/v1/remote_write"
    aws_auth:
      service: "aps"
      region: "${data.aws_region.current.name}"

service:
  pipelines:
    traces:
      receivers: [otlp]
      exporters: [awsxray]
    metrics:
      receivers: [otlp]
      exporters: [logging, awsprometheusremotewrite]
EOT
    filename = "config.yaml"
  }

  output_path = "${path.module}/build/custom-config-layer.zip"
}

resource "aws_lambda_layer_version" "collector_config_layer" {
  depends_on          = [data.archive_file.init]
  layer_name          = "custom-config-layer"
  filename            = "${path.module}/build/custom-config-layer.zip"
  compatible_runtimes = ["java8", "java8.al2", "java11"]
  license_info        = "Apache-2.0"
}
