variable "lambda_role_name" {
  description = "IAM role name for Lambda execution"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  type        = string
}
