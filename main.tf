######### main ec2 resource ##############
module "ec2" {
  source = "./modules/ec2"

  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  sg_id         = var.sg_id
  common_tags   = var.common_tags
}


##################################################################
################ S3 bucket starts from here ######################
##################################################################

module "s3" {
  source = "./modules/s3"
  log_bucket_name = var.log_bucket_name
  secure_bucket_name = var.secure_bucket_name
  versioning_status = var.versioning_status
  common_tags = var.common_tags
}

