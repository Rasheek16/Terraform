provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
            #!/bin/bash
            echo "hello world" >index.html
            nohup busybox httpd -f -p $(var.server_port) &
            EOF

  user_data_replace_on_change = true

  tags = {
    Name = "my first instance"
  }
}