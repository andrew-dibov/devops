# Auth Key : Kubernetes

resource "tls_private_key" "tls__kubernetes" {
  for_each  = toset(values(local.ci__kubernetes_names))
  algorithm = "ED25519"
}

# Local File : Kubernetes : Private Key

resource "local_file" "tls__kubernetes_private_key" {
  for_each = tls_private_key.tls__kubernetes

  filename        = "${var.auth_dir}/${each.key}"
  file_permission = "0600"
  content         = each.value.private_key_openssh
}

# Local File : Kubernetes : Public Key

resource "local_file" "tls__kubernetes_public_key" {
  for_each = tls_private_key.tls__kubernetes

  filename        = "${var.auth_dir}/${each.key}.pub"
  file_permission = "0644"
  content         = each.value.public_key_openssh
}

# Auth Key : Bastion

data "yandex_lockbox_secret" "ls__bastion_ssh_key" {
  secret_id = data.terraform_remote_state.network.outputs.ls__bastion_ssh_key_id
}

data "yandex_lockbox_secret_version" "ls__bastion_ssh_key_version" {
  secret_id = data.yandex_lockbox_secret.ls__bastion_ssh_key.id
}

# Local File : Bastion : Private Key

resource "local_file" "tls__bastion_private_key" {
  filename        = "${var.auth_dir}/${data.terraform_remote_state.network.outputs.ci__bastion_name}"
  file_permission = "0600"
  content         = data.yandex_lockbox_secret_version.ls__bastion_ssh_key_version.entries[0].text_value
}

# Local File : SSH Config

resource "local_file" "lf__ssh_config" {
  filename        = var.lf__ssh_config_filename
  file_permission = "0600"

  content = templatefile("${var.templates_dir}/ssh-config.tftpl", {
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
