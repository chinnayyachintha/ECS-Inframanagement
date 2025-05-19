# This module creates security groups for a VPC in AWS.
# It creates a public security group that allows inbound HTTP and HTTPS traffic from the internet,
# and a private security group that allows inbound traffic only from the public security group.

# public security group
resource "aws_security_group" "public_sg" {
  name        = "${var.public_sg_name}"
  description = "Allow inbound HTTP/HTTPS traffic from the internet"
  vpc_id      = var.vpc_id

  # Ingress Rules (Public Access)
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress Rules (All traffic out)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    { Name = "${var.public_sg_name}" }
  )
}

# private security group
resource "aws_security_group" "private_sg" {
  name        = "${var.private_sg_name}"
  description = "Allow inbound traffic from Public Security Group"
  vpc_id      = var.vpc_id

  # Ingress Rules (Only allow traffic from Public SG)
  ingress {
    description = "Allow access from Public SG"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  # Egress Rules (All traffic out)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    { Name = "${var.private_sg_name}" }
  )
}
