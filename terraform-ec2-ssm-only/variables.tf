variable "aws_profile" {
  type        = string
  default     = "default"
  description = "AWS profile to be used for authentication"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy the resources"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}