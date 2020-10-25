variable "cidr" {
  description = "The VPC cidr block"
  default = "10.0.0.0/16"
}

variable "environment" {
  description = "The name of the environment"
  default = "Terraform_Project"
}

variable "subnet1cidr" {
  description = "The VPC cidr block"
  default = "10.0.1.0/24"
}

variable "subnet2cidr" {
  description = "The VPC cidr block"
  default = "10.0.2.0/24"
}