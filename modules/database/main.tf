resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "DynamoTer"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = var.hashkey

  attribute {
    name = var.hashkey
    type = "S"
  }
  
  tags = {
    Name        = var.environment
    Environment = var.environment
  }  
}