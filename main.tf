terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# using latest ami
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

# using existing vpc
data "aws_vpc" "default_vpc" {
  id = "vpc-04b9661aff908e210"
}

# Using existing subnet
data "aws_subnet" "default_subnet" {
  id = var.subnet_id
}

# Using existing secuirty group
data "aws_security_group" "default_sg" {
  id = var.sg_id
}

##################################################################
####################### EC2 Portion ##############################
##################################################################


######### main ec2 resource ##############
resource "aws_instance" "shahid_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnet.default_subnet.id
  vpc_security_group_ids = [data.aws_security_group.default_sg.id]

  tags = merge(
    var.common_tags,
    {
      Name = "terraform-shahid-ec2"
    }
  )
}

######### Attaching EIP to the instance #############
resource "aws_eip" "shahid_eip" {
  instance = aws_instance.shahid_ec2.id
  domain = "vpc"
}

##################################################################
################ S3 bucket starts from here ######################
##################################################################


########### Log Bucket ###########
resource "aws_s3_bucket" "log_bucket" {
  bucket = var.log_bucket_name
  force_destroy = true

  tags = merge(
    var.common_tags,
    {
    Name= "S3-Logs"
    }
  )
}

# Object Ownership
resource "aws_s3_bucket_ownership_controls" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }

}

# Block Public Access settings for this bucket
resource "aws_s3_bucket_public_access_block" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Bucket Versioning
resource "aws_s3_bucket_versioning" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id

  versioning_configuration {
    status = var.versioning_status
  }
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


########### Secure Bucket ###########
resource "aws_s3_bucket" "secure_bucket" {
  bucket = var.secure_bucket_name
  force_destroy = true
  
  tags = merge(
    var.common_tags,
    {
      Name= "S3-Secure"
    }
  )
}

# Server access logging
resource "aws_s3_bucket_logging" "secure_bucket" {
  bucket        = aws_s3_bucket.secure_bucket.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "access-logs/"
}

# Object Ownership
resource "aws_s3_bucket_ownership_controls" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }

}

# Block Public Access settings for this bucket
resource "aws_s3_bucket_public_access_block" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Bucket Versioning
resource "aws_s3_bucket_versioning" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  versioning_configuration {
    status = var.versioning_status
  }
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bucket Policy
resource "aws_s3_bucket_policy" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.secure_bucket.arn,
          "${aws_s3_bucket.secure_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid       = "DenyUnencryptedObjectUploads"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.secure_bucket.arn}/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" : "AES256"
          }
        }
      }
    ]
  })
}