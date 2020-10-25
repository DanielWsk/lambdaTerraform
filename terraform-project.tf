provider "aws" {
  region                  = "us-east-1"
}

module "api_gateway"{
    source = "./modules/api_gateway"
}

module "database"{
    source = "./modules/database"
}

terraform {
  backend "s3" {
    bucket = "dw-terraform-backend"
    key    = "api-demo"
    region = "us-east-1"
  }
}