# SIEMplicity VPC Outputs
# Author: Latrisha Dodson | Role: Data Quarantine Architect
# Date: October 2025

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.siemplicity_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.siemplicity_vpc.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.siemplicity_igw.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of the public subnets"
  value       = [aws_subnet.public_a.cidr_block, aws_subnet.public_b.cidr_block]
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of the private subnets"
  value       = [aws_subnet.private_a.cidr_block, aws_subnet.private_b.cidr_block]
}

output "quarantine_security_group_id" {
  description = "ID of the quarantine security group"
  value       = aws_security_group.quarantine_sg.id
}

output "flow_logs_bucket_name" {
  description = "Name of the S3 bucket for VPC Flow Logs"
  value       = aws_s3_bucket.flow_logs_bucket.bucket
}

output "flow_logs_bucket_arn" {
  description = "ARN of the S3 bucket for VPC Flow Logs"
  value       = aws_s3_bucket.flow_logs_bucket.arn
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_rt.id
}

output "availability_zones" {
  description = "Availability zones used"
  value       = var.availability_zones
}
