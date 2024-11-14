resource "aws_dynamodb_table" "log_analysis_table" {
  name         = var.log_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "log_id"

  attribute {
    name = "log_id"
    type = "S"
  }

  tags = {
    Environment = var.environment
  }
}

output "table_name" {
  value = aws_dynamodb_table.log_analysis_table.name
}
