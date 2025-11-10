variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "api_stage_name" {
  description = "Stage name (e.g., prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "lambda_methods" {
  description = "Map of HTTP methods to Lambda ARNs"
  type        = map(string)
}
