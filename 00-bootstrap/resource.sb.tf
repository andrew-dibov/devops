# Storage Bucket : State

resource "yandex_storage_bucket" "sb__tfstate" {
  bucket_prefix = var.sb__tfstate_bucket_prefix
  folder_id     = data.yandex_client_config.cc__yandex.folder_id

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
