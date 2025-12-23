# Terraform EC2 + S3 Project

This Terraform project deploys an **AWS EC2 instance**, an **Elastic IP (EIP)**, and two **S3 buckets** (log bucket and secure bucket) with proper security and configuration. The EC2 instance uses the latest Amazon Linux 2023 AMI, is attached to an existing VPC, subnet, and security group, and has an EIP. The S3 buckets include a log bucket and a secure bucket with server access logging, enforced object ownership, block public access settings, versioning, server-side encryption (AES256), and a bucket policy enforcing HTTPS and encrypted uploads.

## Project Structure
```
ec2+s3/
├── main.tf                  # Terraform configuration
├── .gitignore               # Ignore Terraform state and sensitive files
```

## Prerequisites
- Terraform CLI
- AWS account with configured access keys
- Existing VPC, subnet, and security group IDs

## Getting Started
1. Clone the repository (or navigate to your local folder):
```bash
git clone git@github.com:KarimShahid/Terraform-learning.git
cd devops-bootcamp/week6/day2/ec2+s3
```
2. Initialize Terraform:
```bash
terraform init
```
3. Check formatting:
```bash
terraform fmt --check
```
4. Validate configuration:
```bash
terraform validate
```
5. Preview changes:
```bash
terraform plan
```
6. Apply the configuration:
```bash
terraform apply
```
Type `yes` to confirm. Terraform will create the EC2, EIP, and S3 buckets.

## Cleanup
To remove all resources created by this project:
```bash
terraform destroy
```

## Notes
- Terraform state files (`terraform.tfstate`) are ignored in Git to protect sensitive information.
- Ensure bucket names are globally unique if reusing this template.
- You can modify AMI, instance type, and bucket names in `main.tf` as needed.

## Author
**Shahid Karim**  

