terraform {
  required_version = "~> 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "web-infra-portfolio-tfstate-723288728731"
    key            = "dev/network/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "../../modules/network"

  project     = "web-infra-portfolio"
  environment = "dev"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_a_cidr    = "10.0.1.0/24"
  public_subnet_c_cidr    = "10.0.11.0/24"
  private_app_subnet_cidr = "10.0.2.0/24"
  private_db_subnet_cidr  = "10.0.3.0/24"

  public_subnet_a_az    = "ap-northeast-1a"
  public_subnet_c_az    = "ap-northeast-1c"
  private_app_subnet_az = "ap-northeast-1a"
  private_db_subnet_az  = "ap-northeast-1a"
}


module "security_group" {
  source = "../../modules/security-group"

  project     = "web-infra-portfolio"
  environment = "dev"

  vpc_id = module.network.vpc_id

  allowed_http_cidrs  = ["0.0.0.0/0"]
  allowed_https_cidrs = ["0.0.0.0/0"]
}


module "alb" {
  source = "../../modules/alb"

  project     = "web-infra-portfolio"
  environment = "dev"

  vpc_id            = module.network.vpc_id
  alb_sg_id         = module.security_group.alb_sg_id
  public_subnet_ids = module.network.public_subnet_ids
}


module "ec2_apache" {
  source = "../../modules/ec2-apache"

  project     = "web-infra-portfolio"
  environment = "dev"

  ami_id           = var.rocky_ami_id
  subnet_id        = module.network.public_subnet_ids[0]
  apache_sg_id     = module.security_group.apache_sg_id
  target_group_arn = module.alb.apache_target_group_arn
}


