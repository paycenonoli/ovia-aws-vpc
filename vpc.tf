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

# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.ovia-vpc.id
  cidr_block              = "${var.public-subnet-1-cidr}"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags      = {
    Name    = "Public Subnet 1"
  }
}


