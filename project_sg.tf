#------Security group set up-----------
resource "aws_security_group" "http_allow" {
  name        = "http_SSH_allow"
  description = "Enable HTTP access to ec2 instances"

  ingress {
    description = "SSH access from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http_ssh_allow"
  }
}