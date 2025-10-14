###############################################################################
# Logging Module Invocation
# This connects to modules/logging/ and passes all required variables
###############################################################################

module "logging" {
  source = "./modules/logging"

  region                = var.region
  project_prefix        = var.project_prefix
  environment           = var.environment
  opensearch_domain_arn = var.opensearch_domain_arn
  firehose_role_arn     = var.firehose_role_arn
}

# Simple VPC for context (can be expanded later)
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.project_prefix}-vpc"
  }
}
