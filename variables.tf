# ----------------------------------------------------
# Variables
# ----------------------------------------------------
variable "project" {
  type    = string
  default = "terrademo1"
}
# Removed `environment` variable since environment context is now derived from `terraform.workspace` via `local.env`.
# This ensures consistent environment tagging and prevents mismatches between workspace and variable values.
# variable "environment" {
#   type    = string
#   default = "dev"
# }

variable "domain" {
  type    = string
  default = "fieldwork48.com"
}

variable "subdomain_static" {
  type = string

  validation {
    condition     = length(var.subdomain_static) > 0
    error_message = "subdomain_static must not be empty"
  }
}

# AWS Account ID used for OIDC trust policy.
# This is NOT a secret. It's safe to include in public repositories.
variable "account_id" {
  description = "AWSアカウントID（OIDC用）"
  type        = string
  default     = "903636036611"
}

# GitHub repository name used in OIDC condition.
# This is also public information.
variable "repo_name" {
  description = "GitHubリポジトリ名（例: your-org/your-repo）"
  type        = string
  default     = "cloudrobo48/spa"
}
