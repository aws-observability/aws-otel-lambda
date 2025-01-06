variable "function_name" {
  type        = string
  description = "Name of sample app function / API gateway"
  default     = "lambda-nodejs-awssdk-wrapper-amd64"
}

variable "architecture" {
  type        = string
  description = "Lambda function architecture, either arm64 or x86_64"
  default     = "x86_64"
}

variable "runtime" {
  type        = string
  description = "NodeJS runtime version used for sample Lambda Function"
  default     = "nodejs18.x"
}
