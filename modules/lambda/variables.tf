### Lambda resources variables

variable "connections_table_name" {
  type = string
}

variable "on_connect_function_name" {
  type = string
}

variable "on_connect_role_arn" {
  type = string
}

variable "on_disconnect_function_name" {
  type = string
}

variable "on_disconnect_role_arn" {
  type = string
}

variable "send_message_function_name" {
  type = string
}

variable "send_message_role_arn" {
  type = string
}