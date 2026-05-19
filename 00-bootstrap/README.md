# Stage A

https://yandex.cloud/en/docs/iam/concepts/authorization/oauth-token

```bash
echo "export YC_TOKEN=" > .env # положить руками (не светить в терминале)
source .env

export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

terraform init
terraform apply -auto-approve
```

# Stage B

```bash
export AWS_ACCESS_KEY_ID=$(yc lockbox payload get --name ls--tfstate-keys --format json | jq -r '.entries[] | select(.key=="access_key") | .text_value')
export AWS_SECRET_ACCESS_KEY=$(yc lockbox payload get --name ls--tfstate-keys --format json | jq -r '.entries[] | select(.key=="secret_key") | .text_value')

export BUCKET=$(terraform output -raw sb__tfstate)

cat > backend.s3.tf <<EOF
terraform {
  backend "s3" {
    bucket   = "$BUCKET"
    key      = "bootstrap/terraform.tfstate"
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

terraform init -reconfigure
rm *tfstate*

cp terraform.auth.json ../01-network
cp terraform.auth.json ../02-kubernetes

unset YC_TOKEN
```
