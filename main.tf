module "iam" {
  source = "./modules/iam"
  connections_table_arn = module.dynamodb.connections_table_arn
  dynamodb_crud_policy_name = var.dynamodb_crud_policy_name
  web_socket_execution_arn = module.apigatewayv2.web_socket_execution_arn
  on_connect_function_name = var.on_connect_function_name
  on_disconnect_function_name = var.on_disconnect_function_name
  send_message_function_name = var.send_message_function_name
}

module "apigatewayv2" {
  source = "./modules/apigatewayv2"
  simple_chat_web_socket_name = var.simple_chat_web_socket_name
  on_connect_function_invoke_arn = module.lambda.on_connect_function_invoke_arn
  on_disconnect_function_invoke_arn = module.lambda.on_disconnect_function_invoke_arn
  send_message_function_invoke_arn = module.lambda.send_message_function_invoke_arn
}

module "dynamodb" {
  source = "./modules/dynamodb"
  table_configs = var.table_configs
}

module "lambda" {
  source = "./modules/lambda"
  on_connect_function_name = var.on_connect_function_name
  on_disconnect_function_name = var.on_disconnect_function_name
  send_message_function_name = var.send_message_function_name
  on_connect_role_arn = module.iam.on_connect_role_arn
  on_disconnect_role_arn = module.iam.on_disconnect_role_arn
  send_message_role_arn = module.iam.send_message_role_arn
  connections_table_name = var.table_configs.name
}