output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_app_subnet_id" {
  value = module.network.private_app_subnet_id
}

output "private_db_subnet_id" {
  value = module.network.private_db_subnet_id
}

output "alb_sg_id" {
  value = module.security_group.alb_sg_id
}

output "apache_sg_id" {
  value = module.security_group.apache_sg_id
}

output "weblogic_sg_id" {
  value = module.security_group.weblogic_sg_id
}

output "rds_sg_id" {
  value = module.security_group.rds_sg_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "apache_target_group_arn" {
  value = module.alb.apache_target_group_arn
}

output "apache_instance_id" {
  value = module.ec2_apache.apache_instance_id
}

output "apache_private_ip" {
  value = module.ec2_apache.apache_private_ip
}

output "private_db_subnet_ids" {
  value = module.network.private_db_subnet_ids
}

output "weblogic_instance_id" {

  value = module.ec2_weblogic.instance_id
}


