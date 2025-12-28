variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}

######## S3 ########
variable "log_bucket_name" {
  type = string
  description = "Name of the S3 bucket"
  default = "secure-bucket-logs-karim-2025-12-23"
}

variable "secure_bucket_name" {
  type = string
  description = "Name of the S3 bucket"
  default = "secure-bucket-karim-2025-12-23"
}


variable "versioning_status" {
  type        = string
  description = "S3 bucket versioning status (Enabled or Suspended)"
  default     = "Suspended"

  validation {
    condition     = contains(["Enabled", "Suspended"], var.versioning_status)
    error_message = "versioning_status must be either 'Enabled' or 'Suspended'"
  }
}
