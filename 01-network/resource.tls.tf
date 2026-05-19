# Auth Key : Bastion

resource "tls_private_key" "tls__bastion_key" {
  algorithm = "ED25519"
}

resource "yandex_lockbox_secret" "ls__bastion_ssh_key" {
  name = var.ls__bastion_ssh_key_name
}

resource "yandex_lockbox_secret_version" "ls__bastion_ssh_key_version" {
  secret_id = yandex_lockbox_secret.ls__bastion_ssh_key.id

  entries {
    key        = "private_key"
    text_value = tls_private_key.tls__bastion_key.private_key_openssh
  }

  entries {
    key        = "public_key"
    text_value = tls_private_key.tls__bastion_key.public_key_openssh
  }
}


# resource "local_file" "tls__bastion_private_key" {
#   filename        = "${var.auth_dir}/${yandex_compute_instance.ci__bastion.name}"
#   file_permission = "0600"
#   content         = tls_private_key.tls__bastion_key.private_key_openssh
# }

# resource "local_file" "tls__bastion_public_key" {
#   filename        = "${var.auth_dir}/${yandex_compute_instance.ci__bastion.name}.pub"
#   file_permission = "0644"
#   content         = tls_private_key.tls__bastion_key.public_key_openssh
# }
