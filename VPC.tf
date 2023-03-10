#------------VPC.tf file----------
resource "aws_default_vpc" "default" {
}


#---We need to create three new subnets in the default vpc
resource "aws_default_subnet" "my_web_server_public_subnets" {
  availability_zone = element(var.azs, count.index)
  count             = 3
  force_destroy     = true
  tags = {
    Name = "Project Public Subnet ${count.index + 1}"
  }
}
