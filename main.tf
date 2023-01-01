#----------main.tf--------

resource "aws_key_pair" "TFprojectkp" {
  key_name   = "TFprojectkp"
  public_key = tls_private_key.pvt_key.public_key_openssh
}

resource "tls_private_key" "pvt_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "pvt_key" {
  value = tls_private_key.pvt_key.private_key_pem
  sensitive = true
}
resource "local_file" "projectkp" {
  content  = tls_private_key.key_pair.private_key_pem
  filename = "TFprojectkp"
}

resource "aws_instance" "my_web_server" {
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.http_allow.id]
  availability_zone      = element(var.azs, count.index)
  key_name               = "TFprojectkp"

  user_data = <<-EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum -y install nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h2>My NGINX Webserver</h2><br>Built by Terraform" > /var/www/html/index.html"
    EOF
}