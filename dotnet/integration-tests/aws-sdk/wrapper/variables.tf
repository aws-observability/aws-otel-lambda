variable "collector_layer_name" {
  type        = string
  description = "Name of published collector layer"
  default     = "opentelemetry-collector"
}

variable "function_name" {
  type        = string
  description = "Name of sample app function / API gateway"
  default     = "lambda-dotnet-awssdk-wrapper-amd64"
}

variable "architecture" {
  type        = string
  description = "Lambda function architecture, either arm64 or x86_64"
  default     = "x86_64"
}
