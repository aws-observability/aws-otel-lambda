variable "collector_layer_name" {
  type        = string
  description = "Name of published collector layer"
  default     = "opentelemetry-collector"
}

variable "sdk_layer_name" {
  type        = string
  description = "Name of published SDK layer"
  default     = "opentelemetry-java-agent"
}

variable "collector_config_layer_name" {
  type        = string
  description = "Name of published custom config layer"
  default     = "custom-collector-config"
}

variable "function_name" {
  type        = string
  description = "Name of sample app function / API gateway"
  default     = "hello-java-awssdk-agent"
}

