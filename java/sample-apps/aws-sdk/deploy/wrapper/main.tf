data "aws_region" "current" {}

locals {
  architecture_to_arns_mapping = {
    "x86_64" = local.sdk_layer_arns_amd64
    "arm64"  = local.sdk_layer_arns_arm64
  }
}

module "app" {
  source = "../../../../../opentelemetry-lambda/java/sample-apps/aws-sdk/deploy/wrapper"

  name                = var.function_name
  collector_layer_arn = null
  sdk_layer_arn       = local.architecture_to_arns_mapping[var.architecture][data.aws_region.current.name]
  tracing_mode        = "Active"
  architecture        = var.architecture
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.app.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
