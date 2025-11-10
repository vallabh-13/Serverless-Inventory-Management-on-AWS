output "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda"
  value       = aws_iam_role.lambda_exec_role.arn
}
