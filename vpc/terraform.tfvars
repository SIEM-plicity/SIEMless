# SIEMplicity VPC Terraform Variables
# Author: Latrisha Dodson | Role: Data Quarantine Architect
# Date: October 2025

aws_region   = "us-east-1"
project_name = "SIEMplicity"
environment  = "dev"
vpc_cidr     = "10.0.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.10.0/24",
  "10.0.20.0/24"
]

enable_flow_logs         = true
flow_logs_retention_days = 30
