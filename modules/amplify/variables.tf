variable "app_name" {
  description = "Name of the Amplify app"
  type        = string
}

variable "github_repo_url" {
  description = "GitHub repository URL (e.g., https://github.com/username/repo)"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token for Amplify (optional, can connect via console)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "branch_name" {
  description = "Git branch name to deploy (e.g., main, master)"
  type        = string
  default     = "main"
}

variable "api_gateway_url" {
  description = "API Gateway endpoint URL to inject into environment variables"
  type        = string
}

variable "frontend_path" {
  description = "Absolute path to the frontend directory (for local .env file)"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, dev)"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
}
