#------------Variables.tf for project--------------
#---EC2 instance information---
variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type        = string
  description = "AMI of our instance in us-west-2"
  default     = "ami-0ceecbb0f30a902a6"
}

variable "instance_count" {
  type        = number
  description = "number of instances to create"
  default     = 3
}

variable "user_data_replace" {
  default = true
}

#----VPC subnet information----
variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR values for Public Subnets"
  default     = []
}

#--Security group for our WebServer--
variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones for instances"
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "CIDR's for Public Subnets"
  default     = []
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}