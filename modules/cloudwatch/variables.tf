variable "lambda_function_names" {
  description = "List of Lambda function names to create log groups for"
  type        = list(string)
}

variable "log_retention_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 14
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Project identifier"
  type        = string
}
