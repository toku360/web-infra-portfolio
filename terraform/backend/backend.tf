terraform {
  backend "s3" {
    bucket         = "web-infra-portfolio-tfstate-723288728731"
    key            = "backend/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
