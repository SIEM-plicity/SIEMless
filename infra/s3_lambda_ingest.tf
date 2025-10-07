terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "lambda_ingest" {
  bucket = "lambda-ingest-bucket-${random_id.suffix.hex}"
  versioning {
    enabled = true
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = { Service = "lambda.amazonaws.com" }
      Effect    = "Allow"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "s3_ingest" {
  function_name = "S3IngestHandler"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_handler.handler"
  runtime       = "python3.12"
  filename      = "lambda_function_payload.zip"
}

output "bucket_name" {
  value = aws_s3_bucket.lambda_ingest.bucket
}

output "lambda_arn" {
  value = aws_lambda_function.s3_ingest.arn
}