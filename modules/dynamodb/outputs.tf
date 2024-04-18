output "connections_table_arn" {
  value = aws_dynamodb_table.ConnectionsTable.arn
}

output "connections_table_name" {
  value = aws_dynamodb_table.ConnectionsTable.name
}