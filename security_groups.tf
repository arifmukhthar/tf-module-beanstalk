# Security group attached to the Beanstalk's ELB 
# with ingress on 443 and egress on all ports, both rules accept connections from anywhere
resource "aws_security_group" "elb_sg" {
  name        = "sgroup-elb-${var.bc_env}-${var.bc_app_name}"
  description = "Allows HTTPS traffic from the world to the Beanstalk Environment ELB"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.all_tags
}

# Security group attached to the Beanstalk's EC2 instances 
# with ingress on all ports and egress on all ports, both rules accept connections from the ELB SG only
resource "aws_security_group" "ec2_sg" {
  name        = "sgroup-ec2-${var.bc_env}-${var.bc_app_name}"
  description = "Allows all TCP traffic from to Beanstalk Environment ELB to its EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "TLS from VPC"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_sg.id]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.all_tags

}