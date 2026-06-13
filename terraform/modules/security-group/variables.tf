variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "allowed_http_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "allowed_https_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}


