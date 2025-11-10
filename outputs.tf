output "api_url" {
  description = "Base URL of the deployed API Gateway"
  value       = module.api_gateway.api_endpoint
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "lambda_function_names" {
  value = [
    module.lambda_get.lambda_function_name,
    module.lambda_post.lambda_function_name,
    module.lambda_put.lambda_function_name,
    module.lambda_delete.lambda_function_name
  ]
}

output "frontend_url" {
  description = "Public URL to access the frontend application"
  value       = module.amplify.frontend_url
}

output "amplify_app_id" {
  description = "Amplify App ID"
  value       = module.amplify.amplify_app_id
}

output "amplify_console_url" {
  description = "URL to manage the Amplify app in AWS Console"
  value       = module.amplify.amplify_console_url
}

output "amplify_default_domain" {
  description = "Amplify default domain"
  value       = module.amplify.amplify_default_domain
}
