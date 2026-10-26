
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Allow SSH only from your public IP
resource "aws_security_group" "devops_ssh" {
  name        = "devops-capstone-ssh"
  description = "Allow SSH from my computer"

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["58.84.60.171/32"]
  }
  ingress {
    description = "Nginx web access from my IP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["58.84.60.171/32"]
  }
  ingress {
  description = "Flask app from my IP"
  from_port   = 5000
  to_port     = 5000
  protocol    = "tcp"
  cidr_blocks = ["58.84.60.171/32"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-capstone-ssh"
  }
}

resource "aws_instance" "devops_server" {
  ami                    = "ami-0e35ddab05955cf57"
  instance_type          = var.instance_type
  key_name               = "devops-aws-key"
  vpc_security_group_ids = [aws_security_group.devops_ssh.id]

  tags = {
    Name = "devops-capstone-server"
  }
}
output "ec2_public_ip" {
  description = "Public IP address of the DevOps EC2 server"
  value       = aws_instance.devops_server.public_ip
}