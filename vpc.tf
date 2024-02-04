# Create vpc
# terraform aws create vpc
resource "aws_vpc" "ovia-vpc" {
  cidr_block              = "${var.vpc-cidr}"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "ovia-vpc"
  }
}

