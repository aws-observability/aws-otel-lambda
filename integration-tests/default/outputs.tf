output "api-gateway-url" {
  value = module.hello-lambda-function.api-gateway-url
}

output "function-role-name" {
  value = module.hello-lambda-function.function_role_name
}

output "collector-layer-arn" {
  value = module.test.collector_layer_arn
}

output "sdk-layer-arn" {
  value = module.test.sdk_layer_arn
}
