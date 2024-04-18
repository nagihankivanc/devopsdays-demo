### IAM resources variables

variable "dynamodb_crud_policy_name" {
  type = string
}

variable "connections_table_arn" {
  type = string
}

variable "web_socket_execution_arn" {
  type = string
}

variable "on_connect_function_name" {
  type = string
}

variable "on_disconnect_function_name" {
  type = string
}

variable "send_message_function_name" {
  type = string
}