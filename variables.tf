# ----------------------------------------------------
# Variables
# ----------------------------------------------------
variable "project" {
  type    = string
  default = "terrademo1"
}
variable "environment" {
  type    = string
  default = "dev"
}

variable "domain" {
  type    = string
  default = "fieldwork48.com"
}

variable "bucket_name" {
  type    = string
  default = ""
}
