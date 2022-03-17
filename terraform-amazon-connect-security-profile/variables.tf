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

variable "connect_instance_id" {
  type        = string
  default     = "aaaaaaaa-bbbb-cccc-dddd-111111111111"
  description = "Amazon Connect Instance Id"
}