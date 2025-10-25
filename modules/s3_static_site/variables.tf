# ----------------------------------------------------
# Variables
# ----------------------------------------------------
variable "bucket_name" {
  type    = string
  default = "terraform-staticsite-20251021"
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "error_document" {
  type    = string
  default = "error.html"
}

variable "tags" {
  type    = map(string)
  default = {}
}

# This variable receives the ARN of the CloudFront Origin Access Identity (OAI).
# It is used to grant CloudFront permission to access the S3 bucket securely.
variable "cloudfront_oai_arn" {
  type        = string
  description = "ARN of the CloudFront Origin Access Identity"
  default     = null
}