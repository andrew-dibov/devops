resource "tls_private_key" "tls__kubernetes" {
  for_each  = toset(values(local.ci__kubernetes_names))
  algorithm = "ED25519"
}

resource "local_file" "tls__kubernetes_private_key" {
  for_each = tls_private_key.tls__kubernetes

  filename        = "ansible/.auth/${each.key}"
  file_permission = "0600"
  content         = each.value.private_key_openssh
}

resource "local_file" "tls__kubernetes_public_key" {
  for_each = tls_private_key.tls__kubernetes

  filename        = "ansible/.auth/${each.key}.pub"
  file_permission = "0644"
  content         = each.value.public_key_openssh
}

resource "local_file" "tls__bastion_private_key" {
  filename        = "ansible/.auth/${data.terraform_remote_state.network.outputs.ci__bastion_name}"
  file_permission = "0600"
  content         = data.terraform_remote_state.network.outputs.tls__bastion_private_key
}

resource "local_file" "ssh__config" {
  filename        = "ansible/ssh-config"
  file_permission = "0600"

  content = templatefile("templates/ssh-config.tftpl", {
    bastion_ip            = data.terraform_remote_state.network.outputs.ci__bastion_public_ip
    bastion_user          = "debian"
    bastion_identity_file = ".auth/${data.terraform_remote_state.network.outputs.ci__bastion_name}"

    instances = {
      for name, vm in yandex_compute_instance.ci__kubernetes :
      name => {
        hostname      = vm.network_interface[0].ip_address
        user          = "debian"
        identity_file = ".auth/${name}"
      }
    }
  })
}
