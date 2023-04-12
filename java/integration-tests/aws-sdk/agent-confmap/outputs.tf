output "api-gateway-url" {
  value = module.test.api-gateway-url
}

output "sdk-layer-arn" {
  value = module.test.sdk_layer_arn
}

output "amp_endpoint" {
  value = aws_prometheus_workspace.test_amp_workspace.prometheus_endpoint
}
