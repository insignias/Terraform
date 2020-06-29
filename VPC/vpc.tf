#create VPC
resource "aws_vpc" "terraformVPC" {
  cidr_block       = var.VPC-CIDR
  instance_tenancy = "default"

  tags = {
    Name = "terraformVPC"
  }
}

#create public subnet
resource "aws_subnet" "publicSubnet" {
  vpc_id                  = aws_vpc.terraformVPC.id
  cidr_block              = var.publicSubnet-CIDR
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "10.0.1.0-public"
  }
}

#create private subnet
resource "aws_subnet" "privateSubnet" {
  vpc_id                  = aws_vpc.terraformVPC.id
  cidr_block              = var.privateSubnet-CIDR
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = false

  tags = {
    Name = "10.0.2.0-private"
  }
}

#create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraformVPC.id

  tags = {
    Name = "igw"
  }
}

#create route table for public subnet
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.terraformVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Associate route table to public subnet
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.publicSubnet.id
  route_table_id = aws_route_table.public-rt.id
}
