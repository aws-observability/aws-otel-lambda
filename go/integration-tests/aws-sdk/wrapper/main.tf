locals {
  architecture = var.architecture == "x86_64" ? "amd64" : "arm64"
}

resource "aws_lambda_layer_version" "collector_layer" {
  count               = var.enable_collector_layer ? 1 : 0
  layer_name          = var.collector_layer_name
  filename            = "${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip"
  compatible_runtimes = ["provided.al2"]
  license_info        = "Apache-2.0"
  source_code_hash    = filebase64sha256("${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip")
}

module "hello-lambda-function" {
  source              = "../../../../opentelemetry-lambda/go/sample-apps/aws-sdk/deploy/wrapper"
  name                = var.function_name
  architecture        = var.architecture
  collector_layer_arn = var.enable_collector_layer ? aws_lambda_layer_version.collector_layer[0].arn : null
  tracing_mode        = var.tracing_mode
}

resource "aws_iam_role_policy_attachment" "hello-lambda-cloudwatch-insights" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.hello-lambda-function.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
