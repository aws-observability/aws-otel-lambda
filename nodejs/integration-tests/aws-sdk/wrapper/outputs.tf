output "api-gateway-url" {
  value = module.api-gateway.api_gateway_url
}

output "function_role_name" {
  value = module.test-function.lambda_role_name
}

output "collector_layer_arn" {
  value = var.enable_collector_layer ? aws_lambda_layer_version.collector_layer[0].arn : ""
}

output "sdk_layer_arn" {
  value = aws_lambda_layer_version.sdk_layer.arn
}
