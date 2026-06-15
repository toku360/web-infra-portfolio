output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "apache_sg_id" {
  value = aws_security_group.apache.id
}

output "weblogic_sg_id" {
  value = aws_security_group.weblogic.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

