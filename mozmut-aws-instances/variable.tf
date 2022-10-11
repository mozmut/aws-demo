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