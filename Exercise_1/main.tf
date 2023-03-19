terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\tupm2\\.aws\\credentials"]
}

# Provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "ec2_t2" {
  count                  = 4
  ami                    = "ami-02f3f602d23f1659d"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-06190a34b7da8d693"
  vpc_security_group_ids = ["sg-057d64626c9ceb498"]

  tags = {
    Name = "Udacity T2"
  }
}

# Provision 2 m4.large EC2 instances named Udacity M4
#resource "aws_instance" "ec2_m4" {
#  count                  = 2
#  ami                    = "ami-02f3f602d23f1659d"
#  instance_type          = "m4.large"
#  subnet_id              = "subnet-06190a34b7da8d693"
#  vpc_security_group_ids = ["sg-057d64626c9ceb498"]
#
#  tags = {
#    Name = "Udacity M4"
#  }
#}