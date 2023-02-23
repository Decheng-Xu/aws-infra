

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

    Name = "route-public-tbl"
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





resource "aws_security_group" "web_security_group" {
  name = "DechengSg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#create EC2 instance based on your lastest AMI in your AWS account 
data "aws_ami" "webserver" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CSYE6225webapp*"]
  }
}

resource "aws_instance" "ec2-instance" {
  ami = data.aws_ami.webserver.id # Use the AMI ID retrieved by the data block
  #ami = var.ami_id # Replace with your custom AMI ID
  instance_type = "t2.micro"
  key_name = "ec2" 
  #I have a ec2 and ec2.pub in my cd ~/.ssh  
  #In your case, the key_name attribute is 
  #set to "ec2", which means that 
  #you should have a key pair in your AWS account with the name "ec2".
  subnet_id = aws_subnet.public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "DC-ec2"
  }
}

output "public_ip" {
  value = aws_instance.ec2-instance.public_ip
}