# Container Registry : App

resource "yandex_container_registry" "cr__app" {
  name      = var.cr__app_name
  folder_id = data.yandex_client_config.cc__yandex.folder_id
}
