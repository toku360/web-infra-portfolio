resource "aws_iam_role" "ssm" {

  name = "${var.project}-${var.environment}-weblogic-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {

  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {

  name = "${var.project}-${var.environment}-weblogic-profile"

  role = aws_iam_role.ssm.name
}

resource "aws_instance" "weblogic" {

  ami = "ami-0bdd4b6c4c6feca84"

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = aws_iam_instance_profile.ssm.name

  associate_public_ip_address = true
  
  user_data = <<-EOF
  #!/bin/bash
  set -eux

  dnf clean all
  dnf makecache -y

  dnf install -y java-17-openjdk java-17-openjdk-devel unzip tar wget

  mkdir -p /u01/app/oracle/product
  mkdir -p /u01/app/oracle/config
  mkdir -p /u01/app/oracle/logs
  mkdir -p /u01/app/oracle/scripts

  useradd -m -s /bin/bash oracle || true
  chown -R oracle:oracle /u01/app/oracle

  java -version > /u01/app/oracle/logs/java-version.log 2>&1

  EOF


  tags = {

    Name = "${var.project}-${var.environment}-weblogic"

    Project = var.project

    Environment = var.environment

    Role = "weblogic"

    Application = "WebLogic"

    Owner = "toku360"

  }

  user_data_replace_on_change = true

}


