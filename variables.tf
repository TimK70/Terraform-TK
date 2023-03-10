#------------Variables.tf for project--------------
#---EC2 instance information---
variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type        = string
  description = "AMI of our instance in us-east-1"
  default     = "ami-0b5eea76982371e91"
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
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

#define public subnet
variable "public_subnets_cidrs" {
  type        = list(string)
  description = "CIDR's for Public Subnets"
  default     = []
}

variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list
}


data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}