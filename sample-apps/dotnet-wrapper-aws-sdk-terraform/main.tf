data "aws_region" "current" {}

module "app" {
  source = "../../opentelemetry-lambda/dotnet/sample-apps/aws-sdk/deploy/wrapper"

  name                = var.function_name
  collector_layer_arn = lookup(local.collector_layer_arns, data.aws_region.current.name, "invalid")
  tracing_mode        = "Active"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.app.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
