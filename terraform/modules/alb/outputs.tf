output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "apache_target_group_arn" {
  value = aws_lb_target_group.apache.arn
}

output "alb_arn_suffix" {
  value = aws_lb.this.arn_suffix
}

output "apache_target_group_arn_suffix" {
  value = aws_lb_target_group.apache.arn_suffix
}


