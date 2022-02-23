terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-*"]
  }

  filter {
    name   = "block-device-mapping.volume-size"
    values = ["8"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

}

# networking
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  tags = {
    Terraform = "true"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.my_ip}/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = {
    Terraform = "true"
  }
}

# iam
resource "aws_iam_role" "iam_role" {
  name = "terraform_iam_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "terraform_iam_instance_profile"
  role = aws_iam_role.iam_role.name
}

# ec2 instance
resource "aws_instance" "my_server" {

  ami                    = data.aws_ami.amazon_linux_2.id
  iam_instance_profile   = aws_iam_instance_profile.iam_profile.id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.my_sg.id]


  tags = {
    Name      = "TerraformServer"
    Terraform = "true"
  }
}