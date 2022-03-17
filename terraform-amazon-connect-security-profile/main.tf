terraform {
}

provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1"
}

resource "aws_connect_security_profile" "example" {
  instance_id = var.connect_instance_id
  name        = "TerraformSecurityProfile"
  description = "Security Profile created via Terraform"

  permissions = [
    "RoutingPolicies.Create",
    "RoutingPolicies.Edit",
    "RoutingPolicies.View",
  ]

  tags = {
    "Name"      = "Example Security Profile"
    "CreatedBy" = "Terraform"
  }
}

output "security_profile_id" {
  description = "Amazon Connect Security Profile Id"
  value       = aws_connect_security_profile.example.id
}
