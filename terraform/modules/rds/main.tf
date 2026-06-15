resource "aws_db_subnet_group" "this" {
  name       = "wip-${var.environment}-rds-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name        = "wip-${var.environment}-rds-subnet-group"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "wip-${var.environment}-postgres"

  engine         = "postgres"
  engine_version = "16"
  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "appdb"
  username = "appadmin"
  password = var.db_password
  port     = 5432

  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]

  backup_retention_period = 7
  deletion_protection     = false
  skip_final_snapshot     = true
  multi_az                = false

  auto_minor_version_upgrade = true

  tags = {
    Name        = "wip-${var.environment}-postgres"
    Project     = var.project
    Environment = var.environment
    Role        = "database"
  }
}


