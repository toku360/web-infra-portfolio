resource "aws_iam_role" "ssm" {
  name = "${var.project}-${var.environment}-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {
  name = "${var.project}-${var.environment}-ec2-ssm-profile"
  role = aws_iam_role.ssm.name
}

resource "aws_instance" "apache" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.apache_sg_id]
  iam_instance_profile        = aws_iam_instance_profile.ssm.name
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  set -eux

  dnf clean all
  dnf makecache -y
  dnf install -y httpd

  systemctl enable httpd
  systemctl start httpd

  echo "web-infra-portfolio dev apache" > /var/www/html/index.html
  EOF

  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name        = "${var.project}-${var.environment}-apache-ec2"
    Project     = var.project
    Environment = var.environment
    Role        = "apache"
  }
}

resource "aws_lb_target_group_attachment" "apache" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.apache.id
  port             = 80
}



