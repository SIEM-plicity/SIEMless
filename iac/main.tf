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

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_lambda_function" "process_s3_event" {
  function_name = "siem_process_s3_event"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "${path.module}/../automation/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/../automation/lambda_function.zip")
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}

resource "aws_eventbridge_rule" "s3_object_created" {
  name = "s3-object-created-rule"
  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["AWS API Call via CloudTrail"],
    "detail" : { "eventName" : ["PutObject"] }
  })
}

resource "aws_eventbridge_target" "lambda_target" {
  rule = aws_eventbridge_rule.s3_object_created.name
  arn  = aws_lambda_function.process_s3_event.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_s3_event.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_eventbridge_rule.s3_object_created.arn
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_lambda_function" "process_s3_event" {
  function_name = "siem_process_s3_event"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "${path.module}/../automation/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/../automation/lambda_function.zip")
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}

resource "aws_eventbridge_rule" "s3_object_created" {
  name        = "s3-object-created-rule"
  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["AWS API Call via CloudTrail"],
    "detail" : { "eventName" : ["PutObject"] }
  })
}

resource "aws_eventbridge_target" "lambda_target" {
  rule      = aws_eventbridge_rule.s3_object_created.name
  arn       = aws_lambda_function.process_s3_event.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_s3_event.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_eventbridge_rule.s3_object_created.arn
}