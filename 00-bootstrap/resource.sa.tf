resource "yandex_iam_service_account" "sa__terraform" {
  name        = "sa--terraform"
  description = "SA Terraform"
}

# ---

resource "yandex_resourcemanager_folder_iam_member" "sa__storage_admin" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "storage.admin"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__vpc_admin" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "vpc.admin"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__compute_admin" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "compute.admin"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

# ---

resource "yandex_iam_service_account_key" "sa__key_terraform" {
  service_account_id = yandex_iam_service_account.sa__terraform.id

  key_algorithm = "RSA_4096"
  description   = "SA Key Terraform"
}

resource "local_file" "sa__key_terraform_json" {
  filename        = "terraform.auth.json"
  file_permission = "0600"

  content = jsonencode({
    id                 = yandex_iam_service_account_key.sa__key_terraform.id
    service_account_id = yandex_iam_service_account_key.sa__key_terraform.service_account_id
    created_at         = yandex_iam_service_account_key.sa__key_terraform.created_at
    key_algorithm      = yandex_iam_service_account_key.sa__key_terraform.key_algorithm
    public_key         = yandex_iam_service_account_key.sa__key_terraform.public_key
    private_key        = yandex_iam_service_account_key.sa__key_terraform.private_key
  })
}

# ---

resource "yandex_iam_service_account_static_access_key" "sa__key_bucket" {
  service_account_id = yandex_iam_service_account.sa__terraform.id
  description        = "SA Key Bucket"
}

resource "local_file" "sa__key_bucket_json" {
  filename = "bucket.auth.json"

  file_permission = "0600"

  content = jsonencode({
    access_key = yandex_iam_service_account_static_access_key.sa__key_bucket.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa__key_bucket.secret_key
  })
}
