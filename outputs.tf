# For ec2 id
output "instance_id" {
 value       = aws_instance.shahid_ec2.id
 description = "AWS EC2 instance ID"
 sensitive   = false
}

# For eip
output "eip" {
  value = aws_eip.shahid_eip.public_ip
  description = "Public IP address of the EC2 instance"
}

# For public dns
output "ec2_public_dns" {
  value       = aws_instance.shahid_ec2.public_dns
  description = "Public DNS name of the EC2 instance"
}

# For S3 log bucket
output "log_bucket_name" {
  description = "Name of the S3 log bucket"
  value       = aws_s3_bucket.log_bucket.bucket
}


# For S3 secure bucket
output "secure_bucket_name" {
  description = "Name of the secure S3 bucket"
  value       = aws_s3_bucket.secure_bucket.bucket
}


