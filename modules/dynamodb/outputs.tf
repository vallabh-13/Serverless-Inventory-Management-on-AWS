output "table_name" {
  description = "Name of the created DynamoDB table"
  value       = aws_dynamodb_table.coffee_inventory.name
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.coffee_inventory.arn
}
