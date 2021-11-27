module "test" {
  source = "../../../opentelemetry-lambda/${var.language}/integration-tests/default"

  enable_collector_layer = var.enable_collector_layer

  collector_layer_name                = var.collector_layer_name
  collector_layer_zip_path            = var.collector_layer_zip_path
  collector_layer_compatible_runtimes = var.collector_layer_compatible_runtimes

  sdk_layer_name                = var.sdk_layer_name
  sdk_layer_zip_path            = var.sdk_layer_zip_path
  sdk_layer_compatible_runtimes = var.sdk_layer_compatible_runtimes

  function_name                  = var.function_name
  function_terraform_source_path = var.function_terraform_source_path

  collector_config_layer_arn = length(aws_lambda_layer_version.collector_config_layer) > 0 ? aws_lambda_layer_version.collector_config_layer[0].arn : null

  tracing_mode = "Active"
}

resource "aws_iam_role_policy_attachment" "test_xray" {
  role       = module.test.function_role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}
