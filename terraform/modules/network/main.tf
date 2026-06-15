resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project}-${var.environment}-vpc"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-igw"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.public_subnet_a_az
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project}-${var.environment}-public-subnet-a"
    Project     = var.project
    Environment = var.environment
    Tier        = "public"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_c_cidr
  availability_zone       = var.public_subnet_c_az
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project}-${var.environment}-public-subnet-c"
    Project     = var.project
    Environment = var.environment
    Tier        = "public"
  }
}


resource "aws_subnet" "private_app" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_app_subnet_cidr
  availability_zone = var.private_app_subnet_az

  tags = {
    Name        = "${var.project}-${var.environment}-private-app-subnet"
    Project     = var.project
    Environment = var.environment
    Tier        = "private-app"
  }
}

resource "aws_subnet" "private_db" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_db_subnet_cidr
  availability_zone = var.private_db_subnet_az

  tags = {
    Name        = "${var.project}-${var.environment}-private-db-subnet"
    Project     = var.project
    Environment = var.environment
    Tier        = "private-db"
  }
}

resource "aws_subnet" "private_db_c" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_db_subnet_c_cidr
  availability_zone = var.private_db_subnet_c_az

  tags = {
    Name        = "${var.project}-${var.environment}-private-db-subnet-c"
    Project     = var.project
    Environment = var.environment
    Tier        = "private-db"
  }
}

resource "aws_route_table_association" "private_db_c" {
  subnet_id      = aws_subnet.private_db_c.id
  route_table_id = aws_route_table.private_db.id
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-public-rt"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}


resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-private-app-rt"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private_app" {
  subnet_id      = aws_subnet.private_app.id
  route_table_id = aws_route_table.private_app.id
}

resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-private-db-rt"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private_db" {
  subnet_id      = aws_subnet.private_db.id
  route_table_id = aws_route_table.private_db.id
}



