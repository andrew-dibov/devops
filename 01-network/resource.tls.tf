resource "tls_private_key" "tls__bastion_key" {
  algorithm = "ED25519"
}

resource "local_file" "tls__bastion_private_key" {
  filename        = ".auth/${yandex_compute_instance.ci__bastion.name}"
  file_permission = "0600"
  content         = tls_private_key.tls__bastion_key.private_key_openssh
}

resource "local_file" "tls__bastion_public_key" {
  filename        = ".auth/${yandex_compute_instance.ci__bastion.name}.pub"
  file_permission = "0644"
  content         = tls_private_key.tls__bastion_key.public_key_openssh
}
