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