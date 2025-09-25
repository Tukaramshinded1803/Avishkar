provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Avishkar2" {
  ami           = "ami-08982f1c5bf93d976"  # Amazon Linux 2 AMI in us-east-1
  instance_type = "t3.micro"
  key_name      = "test"

  vpc_security_group_ids = ["sg-0038330ea9c8d87e0"]


  tags = {
    Name = "Avishkar2"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "Hello from Terraform EC2!" > /var/www/html/index.html
              EOF
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.Avishkar2.public_ip
}
