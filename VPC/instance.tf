#ssh key to access public subnet
resource "aws_key_pair" "vpcKey" {
  key_name   = "vpcKey"
  public_key = file(var.key_path)
}

resource "aws_instance" "webserver" {
  ami                    = var.amis[var.aws_region]
  instance_type          = var.instance_type
  key_name               = aws_key_pair.vpcKey.key_name
  subnet_id              = aws_subnet.publicSubnet.id
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  user_data              = file("userdata.sh")

  tags = {
    Name = "webserver"
  }
}

resource "aws_instance" "dbserver" {
  ami                    = var.amis[var.aws_region]
  instance_type          = var.instance_type
  key_name               = aws_key_pair.vpcKey.key_name
  subnet_id              = aws_subnet.privateSubnet.id
  vpc_security_group_ids = [aws_security_group.private-sg.id]

  tags = {
    Name = "dbserver"
  }
}
