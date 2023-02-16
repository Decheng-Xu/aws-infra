

provider "aws" {
  region  = var.region
  profile = var.profile
}

# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "igw" {
 
  vpc_id = aws_vpc.vpc.id
}

# Create  3 public subnet 

resource "aws_subnet" "public_subnet" {
  count = var.public_subnets_num
  cidr_block        = cidrsubnet(var.vpc-cidr,8,count.index+10)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "subnet-public-${count.index + 1}"
  }
}

# Create the Public Route Table
resource "aws_route_table" "public_rt" {
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "route-public-table"
  }


  tags = {
    Name = "route-public-table"
  }

}

# Associate the Public Route Table with Public Subnets
resource "aws_route_table_association" "public_subnet_rta" {
  count        = var.public_subnets_num

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

















# Create  3 private subnet 
resource "aws_subnet" "private_subnet" {
  count      = var.private_subnets_num
  cidr_block = cidrsubnet(var.vpc-cidr,8,count.index+1)
  vpc_id     = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "subnet-private-${count.index + 1}"
  }
}


# Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {

    Name = "route-private-table"

  }
}


resource "aws_route_table_association" "private_subnet_rta" {

  count          = var.private_subnets_num
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}