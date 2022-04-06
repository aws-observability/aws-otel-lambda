variable "function_name" {
  type        = string
  description = "Name of sample app function / API gateway"
  default     = "lambda-python-awssdk-wrapper-amd64"
}

variable "architecture" {
  type        = string
  description = "Lambda function architecture, either arm64 or x86_64"
  default     = "x86_64"
}

variable "runtime" {
  type        = string
  description = "Python runtime version used for sample Lambda Function"
  default     = "python3.9"
}
