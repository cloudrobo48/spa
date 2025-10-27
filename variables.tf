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
  type    = string
  default = "static"
}
