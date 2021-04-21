data "aws_region" "current" {}

# TODO(anuraaga): Replace with public layers, these currently only work with authenticated requests for testing.
locals {
  collector_layer_arns = {
    "us-east-1" = "arn:aws:lambda:us-east-1:611364707713:layer:aws-otel-lambda-collector-93d3e85f71b82de431916d03c96f221812d9841b:4"
  }
  sdk_layer_arns = {
    "us-east-1" = "arn:aws:lambda:us-east-1:611364707713:layer:aws-otel-lambda-java-wrapper-93d3e85f71b82de431916d03c96f221812d9841b:1"
  }
}

module "app" {
  source = "../../../../../opentelemetry-lambda/java/sample-apps/okhttp/deploy/wrapper"

  collector_layer_arn    = lookup(local.collector_layer_arns, data.aws_region.current.name, "invalid")
  java_wrapper_layer_arn = lookup(local.sdk_layer_arns, data.aws_region.current.name, "invalid")
}
