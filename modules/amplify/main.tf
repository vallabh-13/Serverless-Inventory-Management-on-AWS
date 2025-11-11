# AWS Amplify App connected to GitHub
resource "aws_amplify_app" "frontend" {
  name       = var.app_name
  repository = var.github_repo_url

  # OAuth token for GitHub access (if provided)
  access_token = var.github_token

  # Build settings for React app in frontend/ subdirectory
  build_spec = <<-EOT
    version: 1
    applications:
      - appRoot: frontend
        frontend:
          phases:
            preBuild:
              commands:
                - npm ci
            build:
              commands:
                - npm run build
          artifacts:
            baseDirectory: build
            files:
              - '**/*'
          cache:
            paths:
              - node_modules/**/*
  EOT

  # Environment variables - API Gateway URL automatically injected
  environment_variables = {
    REACT_APP_API_URL = var.api_gateway_url
  }

  # Enable auto branch creation
  enable_auto_branch_creation = false
  enable_branch_auto_build    = true
  enable_branch_auto_deletion = false

  # Custom rewrite rules for SPA routing
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  custom_rule {
    source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>"
    status = "200"
    target = "/index.html"
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Amplify Branch - connected to your GitHub branch
resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.frontend.id
  branch_name = var.branch_name

  # Enable auto-build on Git push
  enable_auto_build = true

  # Environment variables (same as app level, but can override here)
  environment_variables = {
    REACT_APP_API_URL = var.api_gateway_url
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Trigger a new build when API Gateway URL changes
resource "null_resource" "trigger_amplify_build" {
  # Trigger when API URL changes
  triggers = {
    api_url = var.api_gateway_url
  }

  # Start a new build in Amplify
  provisioner "local-exec" {
    command = "aws amplify start-job --app-id ${aws_amplify_app.frontend.id} --branch-name ${aws_amplify_branch.main.branch_name} --job-type RELEASE"
  }

  depends_on = [
    aws_amplify_app.frontend,
    aws_amplify_branch.main
  ]
}

# Optional: Generate .env file locally for local development
resource "local_file" "env_file" {
  filename = "${var.frontend_path}/.env"
  content  = "REACT_APP_API_URL=${var.api_gateway_url}"
}
