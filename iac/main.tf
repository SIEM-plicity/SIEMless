terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.project}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az_1

  tags = {
    Name = "${var.project}-private-1"
  }
}

output "vpc_id" {
  description = "The VPC id created for this environment"
  value       = aws_vpc.main.id
}

module "logging" {
  source                = "./modules/logging"
  region                = var.region
  environment           = var.environment
  project_prefix        = var.project
  opensearch_domain_arn = var.opensearch_domain_arn
}

