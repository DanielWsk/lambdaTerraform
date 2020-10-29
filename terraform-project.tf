provider "aws" {
  region                  = "us-east-1"
}

module "vpc"{
    source = "./modules/vpc"

    cidr = var.cidr
    pubsubnetcidrs = var.pubsubnetcidrs
    privsubnetcidrs = var.privsubnetcidrs
    environment = var.environment
}

module "api_gateway"{
    source = "./modules/api_gateway"

    lambda_uri = module.lambda.lambda_uri
    lambda_root_uri = module.lambda.lambda_root_uri
    getfuncname = module.lambda.getfuncname
    postfuncname = module.lambda.postfuncname
    environment = var.environment
}

module "lambda"{
    source = "./modules/lambda"

    subnet1id = module.vpc.subnet1id
    subnet2id = module.vpc.subnet2id
    securitygroupid = module.vpc.securitygroupid
    environment = var.environment
}

module "database"{
    source = "./modules/database"

    hashkey = var.hashkey
    environment = var.environment
}

terraform {
  backend "s3" {
    bucket = "dw-terraform-backend"
    key    = "api-demo"
    region = "us-east-1"
  }
}

variable "environment"{}
variable "cidr"{}
variable "pubsubnetcidrs"{}
variable "privsubnetcidrs"{}
variable "hashkey"{}