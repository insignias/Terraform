#ssh key to access public subnet
resource "aws_key_pair" "vpcKey" {
  key_name   = "vpcKey"
  public_key = file(var.key_path)
}

resource "aws_instance" "ebs_extended_instance" {
  ami                    = var.amis[var.aws_region]
  instance_type          = var.instance_type
  availability_zone      = var.aws_availability_zone
  key_name               = aws_key_pair.vpcKey.key_name
  user_data              = file("userdata.sh")

  tags = {
    Name = "ebs_extended_instance"
  }
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = var.aws_availability_zone
  size              = 10
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdb"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.ebs_extended_instance.id
}
