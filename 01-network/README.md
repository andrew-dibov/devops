```bash
cat > backend.s3.tf <<EOF
terraform {
  backend "s3" {
    bucket   = "$BUCKET"
    key      = "network/terraform.tfstate"
    region   = "ru-central1"

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_region_validation      = true
    use_path_style              = true
  }
}
EOF

terraform init
terraform apply -auto-approve
```
