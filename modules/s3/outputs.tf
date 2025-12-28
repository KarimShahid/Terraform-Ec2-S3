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
