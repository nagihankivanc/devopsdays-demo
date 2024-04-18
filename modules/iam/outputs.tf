output "on_connect_role_arn" {
  value = aws_iam_role.OnConnectRole.arn
}

output "on_disconnect_role_arn" {
  value = aws_iam_role.OnDisconnectRole.arn
}

output "send_message_role_arn" {
  value = aws_iam_role.SendMessageRole.arn
}