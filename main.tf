#----------backupproject main.tf--------

resource "aws_key_pair" "wk20projectkp" {
  key_name   = "wk20projectkp"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "wk20projectkp" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "wk20projectkp"
}

resource "aws_instance" "project_web_server" {
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.http_allow.id]
  key_name               = "wk20projectkp"

  user_data = <<-EOF
     "#!/bin/bash
     yum -y update
     yum -y install nginx
     systemctl start nginx
     systemctl enable nginx
     echo "<h2>My NGINX Webserver</h2><br>Built by Terraform" > /var/www/html/index.html"
     EOF

}