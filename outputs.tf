# For ec2 id
output "instance_id" {
 value       = module.ec2.instance_id
 description = "AWS EC2 instance ID"
 sensitive   = false
}

# For eip
output "eip" {
  value = module.ec2.eip
  description = "Public IP address of the EC2 instance"
}

# For public dns
output "ec2_public_dns" {
  value       = module.ec2.ec2_public_dns
  description = "Public DNS name of the EC2 instance"
}

# For S3 log bucket
output "log_bucket_name" {
  description = "Name of the S3 log bucket"
  value       = module.s3.log_bucket_name
}


# For S3 secure bucket
output "secure_bucket_name" {
  description = "Name of the secure S3 bucket"
  value       = module.s3.secure_bucket_name
}


