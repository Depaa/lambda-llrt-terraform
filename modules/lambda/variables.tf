variable "lambda_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "lambda_handler_location" {
  description = "Lambda handler location."
  type        = string
}

variable "lambda_source_dir" {
  description = "Lambda code path location."
  type        = string
}

variable "lambda_source_path" {
  description = "Lambda code src location."
  type        = string
}

variable "lambda_llrt_url" {
  description = "Lambda llrt binary url."
  type        = string
  default     = "https://github.com/awslabs/llrt/releases/latest/download/llrt-lambda-arm64.zip"
}
