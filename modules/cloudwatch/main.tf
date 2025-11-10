resource "aws_cloudwatch_log_group" "lambda_logs" {
  for_each = toset(var.lambda_function_names)

  name              = "/aws/lambda/${each.value}"
  retention_in_days = var.log_retention_days

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
