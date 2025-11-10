output "log_group_names" {
  description = "Names of the created CloudWatch log groups"
  value       = [for name in var.lambda_function_names : "/aws/lambda/${name}"]
}
