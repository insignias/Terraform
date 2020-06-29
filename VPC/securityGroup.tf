#create aws_security_group for private_subnet
resource "aws_security_group" "public-sg" {
  name = "public-sg"
  description = "Allow HTTP, HTTPS, SSH and ICMP traffic"
  vpc_id = aws_vpc.terraformVPC.id

  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["192.168.86.200/32"]
  }

  ingress {
    description = "Allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}

#create aws_security_group for private_subnet
resource "aws_security_group" "private-sg" {
  name        = "private_sg"
  description = "Allow incoming traffic from public subnet"
  vpc_id      = aws_vpc.terraformVPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.publicSubnet-CIDR]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.publicSubnet-CIDR]
  }

  ingress {
    description = "Allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.publicSubnet-CIDR]
  }

  ingress {
    description = "Allow HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.publicSubnet-CIDR]
  }
  tags = {
    Name = "private_sg"
  }
}
