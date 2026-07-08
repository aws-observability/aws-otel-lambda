locals {
  architecture = var.architecture == "x86_64" ? "amd64" : "arm64"
}

resource "aws_lambda_layer_version" "sdk_layer" {
  layer_name          = var.sdk_layer_name
  filename            = "${path.module}/../../../../opentelemetry-lambda/nodejs/packages/layer/build/layer.zip"
  compatible_runtimes = ["nodejs16.x", "nodejs18.x", "nodejs20.x", "nodejs22.x"]
  license_info        = "Apache-2.0"
  source_code_hash    = filebase64sha256("${path.module}/../../../../opentelemetry-lambda/nodejs/packages/layer/build/layer.zip")
}

resource "aws_lambda_layer_version" "collector_layer" {
  count               = var.enable_collector_layer ? 1 : 0
  layer_name          = var.collector_layer_name
  filename            = "${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip"
  compatible_runtimes = ["nodejs16.x", "nodejs18.x", "nodejs20.x", "nodejs22.x"]
  license_info        = "Apache-2.0"
  source_code_hash    = filebase64sha256("${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip")
}

# NOTE: The upstream `nodejs/sample-apps/aws-sdk/deploy/wrapper` module was
# refactored (OTel Collector v0.151.0) to build layer ARNs internally from
# published layer versions and no longer accepts `collector_layer_arn` /
# `sdk_layer_arn` inputs. The integration/soak test must attach the layers we
# just built locally, so we instantiate the Lambda function directly here -
# mirroring the python integration test - instead of consuming that module.
module "test-function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.19.0"

  architectures = compact([var.architecture])
  function_name = var.function_name
  handler       = "index.handler"
  runtime       = var.runtime

  create_package         = false
  local_existing_package = "${path.module}/../../../../opentelemetry-lambda/nodejs/sample-apps/aws-sdk/build/function.zip"

  memory_size = 384
  timeout     = 20

  layers = compact([
    var.enable_collector_layer ? aws_lambda_layer_version.collector_layer[0].arn : null,
    aws_lambda_layer_version.sdk_layer.arn
  ])

  environment_variables = {
    AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-handler"
  }

  tracing_mode = var.tracing_mode
}

module "api-gateway" {
  source = "../../../../opentelemetry-lambda/utils/terraform/api-gateway-proxy"

  name                = var.function_name
  function_name       = module.test-function.lambda_function_name
  function_invoke_arn = module.test-function.lambda_function_invoke_arn
  enable_xray_tracing = var.tracing_mode == "Active"
}

resource "aws_iam_role_policy_attachment" "hello-lambda-cloudwatch-insights" {
  role       = module.test-function.lambda_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.test-function.lambda_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
