# Service Account

resource "yandex_iam_service_account" "sa__terraform" {
  name        = var.sa__terraform_name
  description = var.sa__terraform_description
}

# Service Account : Roles

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_storage_editor" {
  folder_id = data.yandex_client_config.cc__yandex.folder_id

  role   = "storage.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_vpc_admin" {
  folder_id = data.yandex_client_config.cc__yandex.folder_id

  role   = "vpc.admin"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_compute_editor" {
  folder_id = data.yandex_client_config.cc__yandex.folder_id

  role   = "compute.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_load_balancer_editor" {
  folder_id = data.yandex_client_config.cc__yandex.folder_id

  role   = "load-balancer.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_container_registries_editor" {
  folder_id = data.yandex_client_config.cc__yandex.folder_id

  role   = "container-registry.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_lockbox_admin" {
  folder_id = data.yandex_client_config.cc__yandex.folder_id

  role   = "lockbox.admin"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

# Service Account : Key

resource "yandex_iam_service_account_key" "sa__terraform_key" {
  service_account_id = yandex_iam_service_account.sa__terraform.id

  key_algorithm = "RSA_4096"
  description   = var.sa__terraform_key_description
}

resource "local_file" "lf__terraform_key" {
  filename        = var.lf__terraform_key_filename
  file_permission = "0600"

  content = jsonencode({
    id                 = yandex_iam_service_account_key.sa__terraform_key.id
    service_account_id = yandex_iam_service_account_key.sa__terraform_key.service_account_id
    created_at         = yandex_iam_service_account_key.sa__terraform_key.created_at
    key_algorithm      = yandex_iam_service_account_key.sa__terraform_key.key_algorithm
    public_key         = yandex_iam_service_account_key.sa__terraform_key.public_key
    private_key        = yandex_iam_service_account_key.sa__terraform_key.private_key
  })
}

# Service Account : Static Access Key

resource "yandex_iam_service_account_static_access_key" "sa__static_access_key" {
  service_account_id = yandex_iam_service_account.sa__terraform.id
  description        = var.sa__static_access_key_description

  output_to_lockbox {
    secret_id            = yandex_lockbox_secret.ls__tfstate.id
    entry_for_access_key = "access_key"
    entry_for_secret_key = "secret_key"
  }
}

# Lockbox Secret : tfstate

resource "yandex_lockbox_secret" "ls__tfstate" {
  name = var.ls__tfstate_name
}
