# using latest ami
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

# using existing vpc
data "aws_vpc" "default_vpc" {
  id = "vpc-04b9661aff908e210"
}

# Using existing subnet
data "aws_subnet" "default_subnet" {
  id = var.subnet_id
}

# Using existing secuirty group
data "aws_security_group" "default_sg" {
  id = var.sg_id
}

##################################################################
####################### EC2 Portion ##############################
##################################################################


######### main ec2 resource ##############
resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnet.default_subnet.id
  vpc_security_group_ids = [data.aws_security_group.default_sg.id]

  tags = merge(
    var.common_tags,
    {
      Name = "terraform-shahid-ec2"
    }
  )
}

######### Attaching EIP to the instance #############
resource "aws_eip" "this" {
  instance = aws_instance.this.id
  domain = "vpc"
}
