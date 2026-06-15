variable "instance_id" {
  type = string
}

variable "project_short" {
  type    = string
  default = "wip"
}

variable "environment" {
  type = string
}

variable "alb_arn_suffix" {
  type = string
}

variable "target_group_arn_suffix" {
  type = string
}

variable "db_instance_identifier" {
  type = string
}

