# ----------------------------------------------------
# S3 bucket Block
# ----------------------------------------------------
resource "aws_s3_bucket" "apply_log_b" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = var.tags
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

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.apply_log_b.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadForApplyLogs"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket = aws_s3_bucket.apply_log_b.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

