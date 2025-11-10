variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "lambda_handler" {
  description = "Handler entry point (e.g., index.handler)"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda runtime (e.g., nodejs18.x)"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout in seconds"
  type        = number
  default     = 10
}

variable "lambda_memory_size" {
  description = "Memory size in MB"
  type        = number
  default     = 128
}

variable "lambda_zip_path" {
  description = "Path to zipped Lambda source"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Project identifier"
  type        = string
}
