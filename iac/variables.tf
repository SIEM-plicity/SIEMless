# iac/variables.tf
variable "project" { default = "SIEMless" }
variable "region" { default = "us-east-1" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "private_subnet_cidr" { default = "10.0.1.0/24" }
variable "az_1" { default = "us-east-1a" }
variable "aws_profile" {
  description = "AWS CLI profile to use"
  default     = "SIEMplicity-dev-SM"
}
variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  default     = "dev"
}