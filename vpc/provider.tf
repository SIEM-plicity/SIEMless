# SIEMplicity VPC Provider Configuration
# Author: Latrisha Dodson | Role: Data Quarantine Architect
# Date: October 2025

terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "SIEMplicity"
      Environment = "Development"
      Owner       = "Latrisha Dodson"
      Role        = "Data Quarantine Architect"
      Team        = "SOC-SIEM"
      ManagedBy   = "Terraform"
      Purpose     = "VPC Infrastructure for SIEM/SOC Operations"
    }
  }
}
