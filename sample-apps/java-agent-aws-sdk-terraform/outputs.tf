output "api-gateway-url" {
  value = module.app.api-gateway-url
}

output "collector_config_layer_arn" {
  value = length(aws_lambda_layer_version.collector_config_layer) > 0 ? aws_lambda_layer_version.collector_config_layer[0].arn : null
}

output "amp_endpoint" {
  value = length(aws_prometheus_workspace.test_amp_workspace) > 0 ? aws_prometheus_workspace.test_amp_workspace[0].prometheus_endpoint : null
}
