resource "aws_s3_bucket" "archive_ward" {
  bucket = "${var.project_prefix}-logs-${var.environment}"
  tags = {
    Purpose = "SIEM Data Lake"
  }
}
