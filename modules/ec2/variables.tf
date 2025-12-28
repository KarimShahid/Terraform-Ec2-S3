########## EC2 ##########
variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Instance type should be either t2.micro or t3.micro"
  }
}

variable "key_name" {
  type = string
  description = "Key pair for EC2 instance"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID where the web server will be deployed"
  default = "subnet-0591baba4adf985b9"
}

variable "sg_id" {
  type = string
  description = "Security Group ID where the web server will be deployed"
  default = "sg-05dbbd278e09a6b2b"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}