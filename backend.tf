# ----------------------------------------------------
# Terraform Block
# ----------------------------------------------------
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-statefile-20251021"
    region         = "ap-northeast-1"
    dynamodb_table = "Terraform_LockTable_20251021"
    encrypt        = true
    key            = "terraform/state.tfstate"
  }
}
