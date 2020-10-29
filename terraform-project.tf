provider "aws" {
  region                  = "us-east-1"
}

module "api_gateway"{
    source = "./modules/api_gateway"

    lambda_uri = module.lambda.lambda_uri
    lambda_root_uri = module.lambda.lambda_root_uri
    getfuncname = module.lambda.getfuncname
    postfuncname = module.lambda.postfuncname
}

module "lambda"{
    source = "./modules/lambda"

    subnet1id = module.vpc.subnet1id
    subnet2id = module.vpc.subnet2id
    securitygroupid = module.vpc.securitygroupid
}

module "database"{
    source = "./modules/database"
}

module "vpc"{
    source = "./modules/vpc"
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