resource "aws_s3_bucket" "awsb-s3" {
  bucket = var.s3_name
}

resource "aws_s3_bucket_versioning" "test-versioning" {
  bucket = aws_s3_bucket.awsb-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "s3_bucket" {
  value       = aws_s3_bucket.awsb-s3.bucket
  description = "The ARN of the S3 bucket"
}