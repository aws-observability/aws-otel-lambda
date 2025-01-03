variable "collector_layer_name" {
  type        = string
  description = "Name of published collector layer"
  default     = "opentelemetry-collector"
}

variable "sdk_layer_name" {
  type        = string
  description = "Name of published SDK layer"
  default     = "opentelemetry-nodejs-wrapper"
}

variable "architecture" {
  type        = string
  description = "Lambda function architecture, either arm64 or x86_64"
  default     = "x86_64"
}

variable "function_name" {
  type        = string
  description = "Name of sample app function / API gateway"
  default     = "hello-nodejs-awssdk"
}

variable "tracing_mode" {
  type        = string
  description = "Lambda function tracing mode"
  default     = "Active"
}

variable "enable_collector_layer" {
  type        = bool
  description = "Enables building and usage of a layer for the collector. If false, it means either the SDK layer includes the collector or it is not used."
  default     = false
}

variable "runtime" {
  type        = string
  description = "NodeJS runtime version used for sample Lambda Function"
  default     = "nodejs18.x"
}
