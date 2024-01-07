resource "aws_key_pair" "remote_access" {
  key_name   = "main-server-general-access-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpOaPElHstphCdEOZ8p0JxH78kMVf8r0Z3Lqz32jRMLLEO4dAtQVLAr/NPJiNW40Ys0VV+n0LF1BjG3IId43kHr9DV1NkpnDuYemseEvCaLzLUhkyzTbMcCUGtGhAk+y7LnlcbMj1n6hh5nH99F1sjQMAVDBKNBw82jXsIhq1M3Ofh5lQtSnTssquR63q1TgGntrNfNVBT9r4tL9WE0FWCQcKuOWQnzzWST3cYd1KtUd0uti558qHoG1ibWv3YjMel7+geCSQEslESbXbx5aWohsgX4PnmB7OlKB9Et/+n6XPcTNsXuaxXg/KZ8xhpA3WQEPdFeTYOxK8rY9/lOKnT/ahxyHKufWkJUOY30K+Lx+MBbE4p5Ic0Ft9n9HA9T2W6oswNqilhaYfr7rYR2MfbuOjlbhxTiTlqrvJ7XwP/qHFo5iKb9RoHZuBiTNPzs/f8dPD3F2kGj1cI5z2kpJuVU8cb9jnzd/Ix94SG3VxMGiCW1xDbwII5Rccx8I/vCe0="
  tags = {
    Name = "main-server-remote-access-key"
    Stack = "vinipilan/main-server"
    Source = "Terraform"
  }
}

resource "aws_instance" "main_server" {
  ami = data.aws_ami.this.id
  instance_type = var.instance_type
  key_name = aws_key_pair.remote_access.key_name
  security_groups = [aws_security_group.main_security_group.name]

  tags = {
    Name = "main-server"
    Stack = "vinipilan/main-server"
    Source = "Terraform"
  }
}

resource "aws_security_group" "main_security_group" {
  name        = "main_security_group"
  description = "Allow TLS inbound traffic and SSH"

  ingress {
    description      = "Aloow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

#   ingress {
#     description      = "Allow http"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "main-server-security-group"
    Stack = "vinipilan/main-server"
    Source = "Terraform"
  }
}

resource "aws_eip" "main_server_ip" {
  instance = aws_instance.main_server.id

  tags = {
    Name = "main-server-elastic-ip"
    Stack = "vinipilan/main-server"
    Source = "Terraform"
  }
}
