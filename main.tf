# ----------------------------------------------------
# Provider Block
# ----------------------------------------------------
provider "aws" {
#  profile = "terraform"
  region  = "ap-northeast-1"
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

# ----------------------------------------------------
# S3 Bucket Block for tfsate
# ----------------------------------------------------
# for tfstate
resource "aws_s3_bucket" "s3_terraform_statefile" {
  bucket = "terraform-statefile-20251021"
}

resource "aws_s3_bucket_versioning" "s3_terraform_statefile_versioning" {
  bucket = aws_s3_bucket.s3_terraform_statefile.id
  versioning_configuration {
    status = "Enabled"
  }
}

# ----------------------------------------------------
# Dynamodb Block for tfstate
# ----------------------------------------------------
# for tfstate
resource "aws_dynamodb_table" "tf_rock" {
  name         = "Terraform_LockTable_20251021"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = "Terraform Lock Table"
    Environment = var.environment
    Project     = var.project
  }
}
