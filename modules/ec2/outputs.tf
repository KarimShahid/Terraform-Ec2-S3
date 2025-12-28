# For ec2 id
output "instance_id" {
 value       = aws_instance.this.id
 description = "AWS EC2 instance ID"
 sensitive   = false
}

# For eip
output "eip" {
  value = aws_eip.this.public_ip
  description = "Public IP address of the EC2 instance"
}

# For public dns
output "ec2_public_dns" {
  value       = aws_instance.this.public_dns
  description = "Public DNS name of the EC2 instance"
}