variable "awsprops" {
  type = map(string)
  default = {
    region = "eu-west-1"
    ami = "ami-09e2d756e7d78558d"
    itype = "t2.micro"
    publicip = true
    secgroupname = "my security group"
  }
}

variable "instance_names" {
  default = ["1", "2", "3", "4", "5"]
}

variable "vpc" {}
variable "subnet" {}
variable "keyname" {}

variable "userdata" {
  type = map(string)
  default = {
    amazon_ami = <<EOF
#! /bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Deployed via Terraform, Hello World from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
EOF
    ubuntu_ami =<<EOF
#! /bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "<h1>Deployed via Terraform, Hello World from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
EOF
    redhat_ami =<<EOF
#! /bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Deployed via Terraform, Hello World from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
EOF
  }
}