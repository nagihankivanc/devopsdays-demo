variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
}

### Websocket API resources variables

variable "simple_chat_web_socket_name" {
  type = string
}

### Dynamodb resources variables

variable "table_configs" {
  type = object({
    name = string
    billing_mode = string
    hash_key = string
    attributes = object({
      name = string
      type = string
    })
  })
}

### IAM resources variables

variable "dynamodb_crud_policy_name" {
  type = string
}

### Lambda resources variables

variable "on_connect_function_name" {
  type = string
}

variable "on_disconnect_function_name" {
  type = string
}

variable "send_message_function_name" {
  type = string
}
