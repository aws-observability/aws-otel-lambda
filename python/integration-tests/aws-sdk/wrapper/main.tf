locals {
  architecture = var.architecture == "x86_64" ? "amd64" : "arm64"
}

resource "aws_lambda_layer_version" "sdk_layer" {
  layer_name          = var.sdk_layer_name
  filename            = "${path.module}/../../../../opentelemetry-lambda/python/src/build/layer.zip"
  compatible_runtimes = ["python3.10", "python3.9"]
  license_info        = "Apache-2.0"
  source_code_hash    = filebase64sha256("${path.module}/../../../../opentelemetry-lambda/python/src/build/layer.zip")
}

resource "aws_lambda_layer_version" "collector_layer" {
  count               = var.enable_collector_layer ? 1 : 0
  layer_name          = var.collector_layer_name
  filename            = "${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip"
  compatible_runtimes = ["nodejs14.x", "nodejs16.x", "nodejs18.x"]
  license_info        = "Apache-2.0"
  source_code_hash    = filebase64sha256("${path.module}/../../../../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-${local.architecture}.zip")
}

module "test-function" {
  source  = "terraform-aws-modules/lambda/aws"

  architectures = compact([var.architecture])
  function_name = var.function_name
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime

  create_package         = false
  local_existing_package = "${path.module}/../../../sample-apps/build/function.zip"

  memory_size = 384
  timeout     = 20

  layers = compact([
    var.enable_collector_layer ? aws_lambda_layer_version.collector_layer[0].arn : null,
    aws_lambda_layer_version.sdk_layer.arn
  ])

  environment_variables = {
    AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument"
  }

  tracing_mode = var.tracing_mode

  attach_policy_statements = true
  policy_statements = {
    s3 = {
      effect = "Allow"
      actions = [
        "s3:ListAllMyBuckets"
      ]
      resources = [
        "*"
      ]
    }
  }
}

module "api-gateway" {
  source = "../../../../opentelemetry-lambda/utils/terraform/api-gateway-proxy"

  name                = var.function_name
  function_name       = module.test-function.lambda_function_name
  function_invoke_arn = module.test-function.lambda_function_invoke_arn
  enable_xray_tracing = true
}

resource "aws_iam_role_policy_attachment" "hello-lambda-cloudwatch-insights" {
  role       = module.test-function.lambda_function_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.test-function.lambda_function_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
