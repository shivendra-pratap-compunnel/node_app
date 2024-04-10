
#creating ec2 Instance
resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-0c7217cdde317cfec" # change the ami for ubuntu
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
#   user_data              = data.template_file.user_data.rendered
  tags = {
    Name = "my-instance"
  }
}

# data "template_file" "user_data" {
#   template = base64encode(templatefile("${path.module}/script.sh", {}))
# }

# Create Security Group with Custom rules
resource "aws_security_group" "my_security_group" {
  vpc_id = "vpc-08463d2baba49d0bf" #TODO -> Replace the VPC ID
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    description = "Allowing 22 Port For SSH Access "
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    description = "Allowing 80 Port for additional use case"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    description = "Allowing 3000 Port for Node Application "
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "MySecurityGroup"
  }
}

