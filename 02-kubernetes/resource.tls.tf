resource "tls_private_key" "tls__kubernetes" {
  for_each  = toset(values(local.ci__names))
  algorithm = "ED25519"
}

resource "local_file" "tls__kubernetes_private_key" {
  for_each = tls_private_key.tls__kubernetes

  filename        = ".auth/${each.key}"
  file_permission = "0600"
  content         = each.value.private_key_openssh
}

resource "local_file" "tls__kubernetes_public_key" {
  for_each = tls_private_key.tls__kubernetes

  filename        = ".auth/${each.key}.pub"
  file_permission = "0644"
  content         = each.value.public_key_openssh
}

resource "local_file" "tls__bastion_private_key" {
  filename        = ".auth/${data.terraform_remote_state.network.outputs.ci__bastion_name}"
  file_permission = "0600"
  content         = data.terraform_remote_state.network.outputs.tls__bastion_private_key
}

resource "local_file" "ssh__config" {
  filename        = ".auth/ssh-config"
  file_permission = "0600"

  content = templatefile("templates/ssh.cfg.tftpl", {
    bastion_ip = data.terraform_remote_state.network.outputs.ci__bastion_public_ip
    bastion_user = "debian"
    bastion_key = ".auth/${data.terraform_remote_state.network.outputs.ci__bastion_name}"
    
    instances = {
      for name, vm in yandex_compute_instance.ci__kubernetes :
      name => {
        hostname = vm.network_interface[0].ip_address
        user = "debian"
        key = ".auth/${name}"
      }
    }
  })
}



# resource "local_file" "ssh_cfg" {
#   filename = "${var.an__dir}/ssh-config"
#   content = templatefile("${var.tf_tpl__dir}/ssh.cfg.tftpl", {
#     bast = local.inss__names.bast
#     inss = {
#       for name, vm in yandex_compute_instance.inss :
#       name => {
#         is_bast  = name == (local.inss__names.bast)
#         ins_name = name == (local.inss__names.bast) ? vm.network_interface[0].nat_ip_address : vm.network_interface[0].ip_address
#         ins_user = "debian"
#         key_path = "${var.au__dir}/${name}"
#       }
#     }
#   })
#   file_permission = "0600"
# }
