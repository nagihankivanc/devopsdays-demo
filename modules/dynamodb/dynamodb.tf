resource "aws_dynamodb_table" "ConnectionsTable" {
  name           = var.table_configs.name
  billing_mode   = var.table_configs.billing_mode
  hash_key       = var.table_configs.hash_key
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = var.table_configs.attributes.name
    type = var.table_configs.attributes.type
  }

  server_side_encryption {
    enabled = true
  }
}