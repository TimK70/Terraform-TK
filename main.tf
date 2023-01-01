#----------main.tf--------

resource "aws_key_pair" "projectkp" {
  key_name   = "projectkp"
  public_key = tls_private_key.key_pair.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "projectkp" {
  content  = tls_private_key.key_pair.private_key_pem
  filename = "projectkp"
}

resource "aws_instance" "my_web_server" {
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  count                  = var.azs
  vpc_security_group_ids = [aws_security_group.http_allow.id]
  key_name               = "projectkp"

  user_data = <<-EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum -y install nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h2>My NGINX Webserver</h2><br>Built by Terraform" > /var/www/html/index.html"
    EOF
}