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

# Create internet gateway and attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "ovia-igw" {
  vpc_id    = aws_vpc.ovia-vpc.id

  tags      = {
    Name    = "ovia-igw"
  }
}

