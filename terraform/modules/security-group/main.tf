resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.environment}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_http_cidrs
  }

  ingress {
    description = "Allow HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_https_cidrs
  }

  egress {
    description = "Allow outbound to Apache"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-alb-sg"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_security_group" "apache" {
  name        = "${var.project}-${var.environment}-apache-sg"
  description = "Security group for Apache EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description     = "Allow HTTPS from ALB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow outbound to WebLogic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-apache-sg"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_security_group" "weblogic" {
  name        = "${var.project}-${var.environment}-weblogic-sg"
  description = "Security group for WebLogic EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow WebLogic HTTP from Apache"
    from_port       = 7001
    to_port         = 7001
    protocol        = "tcp"
    security_groups = [aws_security_group.apache.id]
  }

  egress {
    description = "Allow outbound to Oracle RDS"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-weblogic-sg"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_security_group" "oracle_rds" {
  name        = "${var.project}-${var.environment}-oracle-rds-sg"
  description = "Security group for Oracle RDS"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow Oracle from WebLogic"
    from_port       = 1521
    to_port         = 1521
    protocol        = "tcp"
    security_groups = [aws_security_group.weblogic.id]
  }

  egress {
    description = "Allow outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-oracle-rds-sg"
    Project     = var.project
    Environment = var.environment
  }
}


