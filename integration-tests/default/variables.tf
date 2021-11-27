variable "collector_layer_name" {
  type        = string
  description = "Name of published collector layer"
  default     = "opentelemetry-collector"
}

variable "sdk_layer_name" {
  type        = string
  description = "Name of published SDK layer"
  default     = "opentelemetry-invalid-name-wrapper"
}

variable "function_name" {
  type        = string
  description = "Name of sample app function / API gateway"
  default     = "test-lambda-invalid-name-awssdk"
}

variable "collector_config_layer_name" {
  type        = string
  description = "Name of published custom config layer"
  default     = "custom-collector-config"
}

variable "language" {
  type        = string
  description = "Language being built - used to find the source terraform upstream."
  default     = "invalid"
}