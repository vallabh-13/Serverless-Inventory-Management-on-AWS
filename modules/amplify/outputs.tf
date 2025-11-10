output "amplify_app_id" {
  description = "ID of the Amplify app"
  value       = aws_amplify_app.frontend.id
}

output "amplify_app_arn" {
  description = "ARN of the Amplify app"
  value       = aws_amplify_app.frontend.arn
}

output "amplify_default_domain" {
  description = "Default domain of the Amplify app"
  value       = aws_amplify_app.frontend.default_domain
}

output "frontend_url" {
  description = "Public URL to access the frontend application"
  value       = "https://${var.branch_name}.${aws_amplify_app.frontend.default_domain}"
}

output "amplify_console_url" {
  description = "URL to the Amplify console for this app"
  value       = "https://console.aws.amazon.com/amplify/home#/${aws_amplify_app.frontend.id}"
}
