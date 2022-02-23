# AWS EC2 (Systems Manager)

This template will spin-up an Amazon EC2 instance with the latest Amazon Linux 2 AMI (HVM), SSD Volume Type (64-bit x86) (gp2) (8gb) **without** a *key pair* and *sg inbound rule* and uses Systems Manager to connect to the instance

## How to use
- Create a `terraform.tfvars` file and include the values to use for the variables defined in `variables.tf` file
- Run `terraform init` command
- Run `terraform apply` command