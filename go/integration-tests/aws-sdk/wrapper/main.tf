module "test" {
  source = "../../../../opentelemetry-lambda/go/integration-tests/aws-sdk/wrapper"

  enable_collector_layer = true
  collector_layer_name   = var.collector_layer_name
  function_name          = var.function_name
  architecture           = var.architecture

  tracing_mode = "Active"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.test.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
