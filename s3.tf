# ----------------------------------------------------
# S3 Bucket Block
# ----------------------------------------------------
# for static site
module "static_site_bucket" {
  source             = "./modules/s3_static_site"
  bucket_name        = "terraform-staticsite-20251021"
  index_document     = "index.html"
  error_document     = "404.html"
  cloudfront_oai_arn = aws_cloudfront_origin_access_identity.oai.iam_arn
  tags = {
    Project     = var.project
    Environment = local.env
    dummy       = "dummy06"
  }
}

# ----------------------------------------------------
# S3 Bucket Block for Apply Log
# ----------------------------------------------------
module "apply_log_bucket" {
  source          = "./modules/apply_log_bucket"
  bucket_name     = "my-apply-logs-${local.env}"
  environment     = local.env
  expiration_days = 30
  tags = {
    Project     = var.project
    Environment = local.env
  }
}