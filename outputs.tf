#---------Outputs.tf file------------
#-----output file to get public_ip of our instance----------
output "instance_public_ip" {
    value = [for i in aws_instance.project_web_server[*] : i.public_ip]
    description = "The Public IP of the project_web_server insances."
}
