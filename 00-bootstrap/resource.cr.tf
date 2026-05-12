resource "yandex_container_registry" "cr__app_registry" {
  name      = "cr--app-registry"
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id
}
