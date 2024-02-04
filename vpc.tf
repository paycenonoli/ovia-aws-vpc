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

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.ovia-vpc.id
  cidr_block              = "${var.public-subnet-2-cidr}"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet 2"
  }
}

# Create Route Table and add public route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.ovia-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ovia-igw.id
  }

  tags       = {
    Name     = "Public Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-1.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-2.id
  route_table_id      = aws_route_table.public-route-table.id
}








