#
# Outputs.
#

output "ConnectionsTableArn" {
  value = module.dynamodb.connections_table_arn
}

output "OnConnectFunctionArn" {
  value = module.lambda.on_connect_function_arn
}

output "OnDisconnectFunctionArn" {
  value = module.lambda.on_disconnect_function_arn
}

output "SendMessageFunctionArn" {
  value = module.lambda.send_message_function_arn
}

output "WebSocketURI" {
  value = module.apigatewayv2.web_socket_uri
}