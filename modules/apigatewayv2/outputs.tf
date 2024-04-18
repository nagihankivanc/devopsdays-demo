output "web_socket_uri" {
  value = aws_apigatewayv2_stage.Stage.invoke_url
}

output "web_socket_execution_arn" {
  value = aws_apigatewayv2_api.SimpleChatWebSocket.execution_arn
}