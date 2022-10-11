provider "aws" {
  region = lookup(var.awsprops, "region")
}

resource "aws_security_group" "project-iac-sg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = var.vpc

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Ping Transport
  ingress {
    from_port = 8
    protocol = "icmp"
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_integer" "test" {
  min = 1
  max = 50000
}

resource "aws_instance" "mozmut-project-iac" {
  count = 1
  #ami = lookup(var.awsprops, "ami")
  #user_data = var.userdata.amazon_ami
  ami = data.aws_ami.ubuntu-linux-2004.id
  user_data = var.userdata.ubuntu_ami
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = var.subnet
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = var.keyname

  vpc_security_group_ids = [
    aws_security_group.project-iac-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    #Name ="mozmut-instance-${random_integer.test.result}"
    Name = "mozmut-instance-${element(var.instance_names, count.index)}"
    Environment = "DEV"
    OS = "AMAZON"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.project-iac-sg ]
}


output "ec2instance" {
  value = ["${ aws_instance.mozmut-project-iac.*.public_ip }"]
}