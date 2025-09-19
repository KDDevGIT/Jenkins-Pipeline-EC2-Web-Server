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

