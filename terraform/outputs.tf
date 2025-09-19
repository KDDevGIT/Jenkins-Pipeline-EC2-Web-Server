output "public_ip" {
  value = aws_instance.web.public_ip
  description = "Public IP of Web Server"
}

output "public_dns" {
  value = aws_instance.web.public_dns
  description = "Public DNS of the Web Server"
}

output "security_group_id" {
  value = aws_security_group.web_sg.id 
  description = "ID of the Security Group"
}
