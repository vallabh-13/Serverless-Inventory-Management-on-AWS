variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_account_id" {
  description = "Your AWS account ID"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "project_name" {
  description = "Project identifier"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "lambda_role_name" {
  description = "IAM role name for Lambda functions"
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 14
}

variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "api_stage_name" {
  description = "Stage name for API Gateway"
  type        = string
}

variable "amplify_app_name" {
  description = "Name of the Amplify app"
  type        = string
}

variable "github_repo_url" {
  description = "GitHub repository URL (e.g., https://github.com/username/repo)"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token for Amplify (leave empty to connect via console)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "branch_name" {
  description = "Git branch name to deploy"
  type        = string
  default     = "main"
}

variable "frontend_path" {
  description = "Absolute path to the frontend directory"
  type        = string
}
