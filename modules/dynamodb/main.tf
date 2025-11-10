resource "aws_dynamodb_table" "coffee_inventory" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"  # No need to manage read/write capacity

  hash_key     = "coffee_name"

  attribute {
    name = "coffee_name"
    type = "S"  # String type for primary key
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
