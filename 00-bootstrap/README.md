# Stage A

```bash
# https://yandex.cloud/en/docs/iam/concepts/authorization/oauth-token

echo "export YC_TOKEN=" > .env # положить руками в файл (не светить в истории)
echo "export YC_CLOUD_ID=$(yc config get cloud-id)" >> .env
echo "export YC_FOLDER_ID=$(yc config get folder-id)" >> .env

source .env
```

```bash
terraform init
terraform apply
```

# Stage B

```bash
echo "export AWS_ACCESS_KEY_ID=$(terraform output -raw os__tfstate_access_key)" >> .env
echo "export AWS_SECRET_ACCESS_KEY=$(terraform output -raw os__tfstate_secret_key)" >> .env

source .env
```

```bash
export BUCKET=$(terraform output -raw os__tfstate_bucket)

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
```

```bash
terraform init -reconfigure
rm *tfstate*
```
