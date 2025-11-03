# ----------------------------------------------------
# S3 bucket Block
# ----------------------------------------------------
resource "aws_s3_bucket" "apply_log_b" {
  bucket = var.bucket_name
  force_destroy = true

  tags   = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "log_lifecycle" {
  bucket = aws_s3_bucket.apply_log_b.id

  rule {
    id     = "expire-logs"
    status = "Enabled"

    expiration {
      days = var.expiration_days
    }
  }
}
