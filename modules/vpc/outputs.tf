output "vpcId"{
    value = aws_vpc.tf-vpc.id
}

output "subnet1id"{
    value = aws_subnet.privatesubnet1.id
}

output "subnet2id"{
    value = aws_subnet.privatesubnet2.id
}

output "securitygroupid"{
    value = aws_security_group.security-group1.id
}