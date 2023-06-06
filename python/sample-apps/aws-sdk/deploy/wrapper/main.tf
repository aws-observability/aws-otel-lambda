data "aws_region" "current" {}

locals {
  architecture_to_arns_mapping = {
    "x86_64" = local.sdk_layer_arns_amd64
    "arm64"  = local.sdk_layer_arns_arm64
  }
}

module "test-function" {
  source  = "terraform-aws-modules/lambda/aws"

  architectures = compact([var.architecture])
  function_name = var.function_name
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime

  create_package         = false
  local_existing_package = "${path.module}/../../../build/function.zip"

  memory_size = 384
  timeout     = 20

  layers = compact([
    null,
    local.architecture_to_arns_mapping[var.architecture][data.aws_region.current.name]
  ])

  environment_variables = {
    AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument"
  }

  tracing_mode = "Active"

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
  source = "../../../../../opentelemetry-lambda/utils/terraform/api-gateway-proxy"

  name                = var.function_name
  function_name       = module.test-function.lambda_function_name
  function_invoke_arn = module.test-function.lambda_function_invoke_arn
  enable_xray_tracing = true
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.test-function.lambda_function_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
