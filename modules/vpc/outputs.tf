output "vpcId"{
    value = aws_vpc.tf-vpc.id
}

output "subnet1id"{
    value = aws_subnet.public-subnet1.id
}

output "subnet2id"{
    value = aws_subnet.public-subnet2.id
}

output "securitygroupid"{
    value = aws_security_group.security-group1.id
}