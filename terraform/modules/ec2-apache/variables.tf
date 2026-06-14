variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
}

variable "subnet_id" {
  type = string
}

variable "apache_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}
