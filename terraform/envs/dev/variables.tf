variable "rocky_ami_id" {
  type        = string
  description = "Rocky Linux 9 AMI ID in ap-northeast-1"
}

variable "db_password" {
  type      = string
  sensitive = true
}
