# Amazon Connect - Security Profile

This template will create an Amazon Connect security profile. 

For a list of all security profile permissions that you can place in the `aws_connect_security_profile` resource `permissions` block, refer to this AWS documentation: https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html

## How to use
- Create a `terraform.tfvars` file and include the values to use for the variables defined in `variables.tf` file
- Run `terraform init` command
- Run `terraform apply` command