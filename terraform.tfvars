############################
########## EC2 ############
############################

instance_type = "t3.micro"
key_name      = "awsKeyPair"
subnet_id = "subnet-0591baba4adf985b9"
sg_id     = "sg-05dbbd278e09a6b2b"

common_tags = {
  Project     = "Terraform-Learning"
  Environment = "Dev"
  ManagedBy   = "Terraform"
}

############################
########## S3 #############
############################

log_bucket_name    = "secure-bucket-logs-karim-2025-12-23"
secure_bucket_name = "secure-bucket-karim-2025-12-23"

versioning_status = "Enabled"



