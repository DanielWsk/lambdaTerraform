variable "cidr" {
  description = "The VPC cidr block"
  default = "10.0.0.0/16"
}

variable "environment" {
  description = "The name of the environment"
  default = "Terraform_Project"
}

variable "pubsubnet1cidr" {
  description = "The VPC cidr block"
  default = "10.0.1.0/24"
}

variable "pubsubnet2cidr" {
  description = "The VPC cidr block"
  default = "10.0.2.0/24"
}

variable "privsubnet1cidr" {
  description = "The VPC cidr block"
  default = "10.0.3.0/24"
}

variable "privsubnet2cidr" {
  description = "The VPC cidr block"
  default = "10.0.4.0/24"
}

variable "pubsubnetcidrs" {
  type = list(string)
  description = "cidr blocks for public subnets"
}

variable "privsubnetcidrs" {
  type = list(string)
  description = "cidr blocks for private subnets"
}

variable "azs" {
  description = "List of availability zones names in the region"
  type        = list(string)
}