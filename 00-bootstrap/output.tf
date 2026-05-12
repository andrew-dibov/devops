output "os__tfstate_bucket" {
  value = yandex_storage_bucket.os__tfstate.bucket
}

output "os__tfstate_access_key" {
  value     = yandex_iam_service_account_static_access_key.sa__key_bucket.access_key
  sensitive = true
}

output "os__tfstate_secret_key" {
  value     = yandex_iam_service_account_static_access_key.sa__key_bucket.secret_key
  sensitive = true
}

output "cr__app_registry_id" {
  value = yandex_container_registry.cr__app_registry.id
}

output "cr__app_registry_name" {
  value = yandex_container_registry.cr__app_registry.name
}
