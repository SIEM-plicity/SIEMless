#############################################################
# SIEMplicity VPC Infrastructure
# Author: Latrisha Dodson
# Purpose: SOC/SIEM Environment Network Architecture
#############################################################

# ------------------------
# VPC Definition
# ------------------------
resource "aws_vpc" "siemplicity_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "siemplicity-vpc"
    Environment = "dev"
    Project     = "SIEMplicity"
  }
}

# ------------------------
# Internet Gateway
# ------------------------
resource "aws_internet_gateway" "siemplicity_igw" {
  vpc_id = aws_vpc.siemplicity_vpc.id

  tags = {
    Name        = "siemplicity-igw"
    Environment = "dev"
  }
}

# ------------------------
# Public Subnets
# ------------------------
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.siemplicity_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "siemplicity-public-a"
    Environment = "dev"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.siemplicity_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "siemplicity-public-b"
    Environment = "dev"
  }
}

# ------------------------
# Private Subnets
# ------------------------
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.siemplicity_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name        = "siemplicity-private-a"
    Environment = "dev"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.siemplicity_vpc.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name        = "siemplicity-private-b"
    Environment = "dev"
  }
}

# ------------------------
# Public Route Table (Internet Access)
# ------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.siemplicity_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.siemplicity_igw.id
  }

  tags = {
    Name        = "siemplicity-public-rt"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

# ------------------------
# Private Route Table (Internal Only)
# ------------------------
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.siemplicity_vpc.id

  tags = {
    Name        = "siemplicity-private-rt"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt.id
}

# ------------------------
# S3 Flow Logs Bucket (Globally Unique)
# ------------------------
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "flow_logs_bucket" {
  bucket = "siemplicity-flow-logs-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "siemplicity-flow-logs"
    Environment = "dev"
  }
}

# ------------------------
# VPC Flow Logs (to S3)
# ------------------------
resource "aws_flow_log" "vpc_flow_logs" {
  log_destination      = aws_s3_bucket.flow_logs_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.siemplicity_vpc.id

  tags = {
    Name        = "siemplicity-vpc-flow-logs"
    Environment = "dev"
  }
}

# -------------------------------------------------
# Quarantine Security Group (for SOC containment)
# -------------------------------------------------
resource "aws_security_group" "quarantine_sg" {
  name        = "siemplicity-quarantine-sg"
  description = "Restricts all inbound/outbound traffic for isolated instances"
  vpc_id      = aws_vpc.siemplicity_vpc.id

  # No ingress or egress rules — complete lockdown
  revoke_rules_on_delete = true

  tags = {
    Name        = "siemplicity-quarantine-sg"
    Environment = "dev"
    Purpose     = "Containment"
  }
}

#############################################################
# End of File
#############################################################
