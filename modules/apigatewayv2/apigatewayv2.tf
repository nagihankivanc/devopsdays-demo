#
# WebSocket API resources.
#

resource "aws_apigatewayv2_api" "SimpleChatWebSocket" {
  name                       = var.simple_chat_web_socket_name
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.message"
}

resource "aws_apigatewayv2_deployment" "Deployment" {
  api_id = aws_apigatewayv2_api.SimpleChatWebSocket.id

  depends_on = [
    aws_apigatewayv2_route.ConnectRoute,
    aws_apigatewayv2_route.DisconnectRoute,
    aws_apigatewayv2_route.SendRoute,
  ]
}

resource "aws_apigatewayv2_stage" "Stage" {
  api_id        = aws_apigatewayv2_api.SimpleChatWebSocket.id
  name          = "dev"
  description   = "Dev Stage"
  deployment_id = aws_apigatewayv2_deployment.Deployment.id
}

###########
# OnConnect
###########
resource "aws_apigatewayv2_integration" "ConnectIntegration" {
  api_id             = aws_apigatewayv2_api.SimpleChatWebSocket.id
  integration_type   = "AWS_PROXY"
  description        = "Connect Integration"
  integration_uri    = var.on_connect_function_invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "ConnectRoute" {
  api_id         = aws_apigatewayv2_api.SimpleChatWebSocket.id
  route_key      = "$connect"
  operation_name = "ConnectRoute"
  target         = "integrations/${aws_apigatewayv2_integration.ConnectIntegration.id}"
}

##############
# OnDisconnect
##############
resource "aws_apigatewayv2_integration" "DisconnectIntegration" {
  api_id             = aws_apigatewayv2_api.SimpleChatWebSocket.id
  integration_type   = "AWS_PROXY"
  description        = "Disconnect Integration"
  integration_uri    = var.on_disconnect_function_invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "DisconnectRoute" {
  api_id         = aws_apigatewayv2_api.SimpleChatWebSocket.id
  route_key      = "$disconnect"
  operation_name = "DisconnectRoute"
  target         = "integrations/${aws_apigatewayv2_integration.DisconnectIntegration.id}"
}

#############
# SendMessage
#############
resource "aws_apigatewayv2_integration" "SendIntegration" {
  api_id             = aws_apigatewayv2_api.SimpleChatWebSocket.id
  integration_type   = "AWS_PROXY"
  description        = "Send Integration"
  integration_uri    = var.send_message_function_invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "SendRoute" {
  api_id         = aws_apigatewayv2_api.SimpleChatWebSocket.id
  route_key      = "sendmessage"
  operation_name = "SendRoute"
  target         = "integrations/${aws_apigatewayv2_integration.SendIntegration.id}"
}