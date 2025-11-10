resource "aws_lambda_function" "function" {
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size
  filename      = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
      ENVIRONMENT    = var.environment
      PROJECT_NAME   = var.project_name
    }
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
