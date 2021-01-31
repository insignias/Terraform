resource "aws_key_pair" "ec2key" {
  key_name = "terraformkey"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "EC2withSG" {
  ami = "ami-01aab85a5e4a5a0fe"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2key.key_name
  security_groups = [aws_security_group.testSG.name]
  tags = {
    Name = "EC2withSG"
  }
}

