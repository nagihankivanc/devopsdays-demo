# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

aws_region = "eu-west-1"

simple_chat_web_socket_name = "SimpleChatWebSocket"


table_configs = {
  name = "simplechat_connections"
  billing_mode = "PROVISIONED"
  hash_key = "connectionId"
  attributes = {
    name = "connectionId"
    type = "S"
  }
}

dynamodb_crud_policy_name = "DynamoDBCrudPolicy"

on_connect_function_name = "OnConnectFunction"
on_disconnect_function_name = "OnDisconnectFunction"
send_message_function_name = "SendMessageFunction"