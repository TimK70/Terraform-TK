#------------VPC.tf file----------
data "aws_vpc" "default" {
  default = true
}

#---We need to create three new subnets in the default vpc
resource "aws_default_subnet" "project_public_subnets" {
  availability_zone = element(var.azs, count.index)
  count             = 3
  force_destroy     = true
  tags = {
    Name = "Project Public Subnet ${count.index + 1}"
  }
}
