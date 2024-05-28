resource "aws_dynamodb_table" "dyn_tab" {
  name = var.dyn_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}