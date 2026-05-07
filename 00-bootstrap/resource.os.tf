resource "yandex_storage_bucket" "os__tfstate" {
  bucket_prefix = "tfstate-"

  access_key = yandex_iam_service_account_static_access_key.sa__key_bucket.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa__key_bucket.secret_key

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
