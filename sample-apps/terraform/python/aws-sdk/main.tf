data "aws_region" "current" {}

# TODO(anuraaga): Replace with public layers, these currently only work with authenticated requests for testing.
locals {
  sdk_layer_arns = {
    "ap-northeast-1" = "arn:aws:lambda:ap-northeast-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "ap-northeast-2" = "arn:aws:lambda:ap-northeast-2:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "ap-northeast-3" = "arn:aws:lambda:ap-northeast-3:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "ap-south-1" = "arn:aws:lambda:ap-south-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "ap-southeast-1" = "arn:aws:lambda:ap-southeast-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "ap-southeast-2" = "arn:aws:lambda:ap-southeast-2:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "ca-central-1" = "arn:aws:lambda:ca-central-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "eu-central-1" = "arn:aws:lambda:eu-central-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "eu-north-1" = "arn:aws:lambda:eu-north-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "eu-west-1" = "arn:aws:lambda:eu-west-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "eu-west-2" = "arn:aws:lambda:eu-west-2:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "eu-west-3" = "arn:aws:lambda:eu-west-3:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "sa-east-1" = "arn:aws:lambda:sa-east-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "us-east-1" = "arn:aws:lambda:us-east-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "us-east-2" = "arn:aws:lambda:us-east-2:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "us-west-1" = "arn:aws:lambda:us-west-1:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
    "us-west-2" = "arn:aws:lambda:us-west-2:901920570463:layer:aws-otel_python38_ver-0-0-0:1"
  }
}

module "app" {
  source = "../../../../opentelemetry-lambda/python/sample-apps/deploy"

  name                = var.function_name
  collector_layer_arn = null
  sdk_layer_arn       = lookup(local.sdk_layer_arns, data.aws_region.current.name, "invalid")
}
