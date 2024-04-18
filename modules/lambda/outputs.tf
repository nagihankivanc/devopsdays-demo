
output "on_connect_function_arn" {
  value = aws_lambda_function.OnConnectFunction.arn
}

output "on_disconnect_function_arn" {
  value = aws_lambda_function.OnDisconnectFunction.arn
}

output "send_message_function_arn" {
  value = aws_lambda_function.SendMessageFunction.arn
}

output "on_connect_function_invoke_arn" {
  value = aws_lambda_function.OnConnectFunction.invoke_arn
}

output "on_disconnect_function_invoke_arn" {
  value = aws_lambda_function.OnDisconnectFunction.invoke_arn
}

output "send_message_function_invoke_arn" {
  value = aws_lambda_function.SendMessageFunction.invoke_arn
}