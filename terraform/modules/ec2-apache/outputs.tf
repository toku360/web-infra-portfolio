output "apache_instance_id" {
  value = aws_instance.apache.id
}

output "apache_private_ip" {
  value = aws_instance.apache.private_ip
}
