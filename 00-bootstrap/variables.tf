# Container Registry

variable "cr__app_name" {
  type    = string
  default = "cr--app"
}

# Storege Bucket

variable "sb__tfstate_bucket_prefix" {
  type    = string
  default = "tfstate-"
}

# Service Account

variable "sa__terraform_name" {
  type    = string
  default = "sa--terraform"
}

variable "sa__terraform_description" {
  type    = string
  default = "Service account for Terraform"
}

variable "sa__terraform_key_description" {
  type    = string
  default = "Service account key for Terraform"
}

variable "lf__terraform_key_filename" {
  type    = string
  default = "terraform.auth.json"
}

variable "sa__static_access_key_description" {
  type    = string
  default = "Service account static access key for Terraform"
}

# Lockbox Secret

variable "ls__tfstate_name" {
  type    = string
  default = "ls--tfstate-keys"
}
