data "aws_ami" "al2023" {
  most_recent = true 
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# Security Group Allowing Inbound HTTP/Outbound Anywhere
resource "aws_security_group" "web_sg" {
  name = "web-sg-${var.environment}"
  description = "Allow HTTP on nginx"
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.allowed_http_cidrs
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance with user_data installing nginx and simple index page
resource "aws_instance" "web" {
  ami = data.aws_ami.al2023.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = var.key_name
  user_data = file("${path.module}/user_data.sh")
  tags = {
    Name = "web-${var.environment}"
  }
}

