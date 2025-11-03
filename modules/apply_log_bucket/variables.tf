variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket to store apply logs"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, prod)"
}

variable "expiration_days" {
  type        = number
  default     = 30
  description = "Number of days before apply logs expire"
}

variable "tags" {
  type    = map(string)
  default = {}
}
