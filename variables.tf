variable "repository_name" {
  type = string
}

variable "path" {
  type = string
}

variable "stage" {
  type = string
}

variable "logs_arn" {
  type = string
}

variable "websocket_domain" {
  type    = string
  default = ""
}

variable "websocket_domain_id" {
  type    = string
  default = ""
}
