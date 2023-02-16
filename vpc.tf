# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "hw3 VPC"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Integer Gateway"
  }
}

locals {
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

# Create 3 public Subnet
resource "aws_subnet" "public" {
  count      = 3
  cidr_block = "10.0.${count.index + 1}.0/24"
  vpc_id     = aws_vpc.vpc.id
  availability_zone = local.availability_zones[count.index]
  tags = {
    Name = "subnet-public-${count.index + 1}"
  }
}




# Create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags = {
    Name = "route-table-public"
  }
}

# Create public route_table asscoation
resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
# Create  3 private subnet 
resource "aws_subnet" "private" {
  count      = 3
  cidr_block = "10.0.${count.index + 4}.0/24"
  vpc_id     = aws_vpc.vpc.id
  availability_zone = local.availability_zones[count.index]
  tags = {
    Name = "subnet-private-${count.index + 1}"
  }
}

# Create private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "route-private"
  }
}
# Create private route association
resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}