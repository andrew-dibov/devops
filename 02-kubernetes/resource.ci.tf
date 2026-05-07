resource "yandex_compute_instance" "ci__kubernetes" {
  for_each = local.ci__configs

  zone        = each.value.zone
  platform_id = "standard-v3"

  name        = each.key
  hostname    = each.value.hostname
  description = each.value.description

  resources {
    cores         = each.value.resources.cores
    memory        = each.value.resources.memory
    core_fraction = each.value.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ci__debian.id
      size     = each.value.initialize_params.size
    }
  }

  network_interface {
    subnet_id          = each.value.network_interface.subnet_id
    nat                = each.value.network_interface.nat
    security_group_ids = each.value.network_interface.security_group_ids
  }

  scheduling_policy {
    preemptible = each.value.scheduling_policy.preemptible
  }

  metadata = {
    ssh-keys  = "debian:${tls_private_key.tls__kubernetes[each.key].public_key_openssh}"
    user-data = ""
  }

  labels = {
    role = each.value.role
  }
}

# resource "yandex_compute_instance" "ci__bastion" {
#   zone        = yandex_vpc_subnet.vpc__subnet_public_a.zone
#   platform_id = "standard-v3"

#   name        = "ci--bastion"
#   hostname    = "bastion"
#   description = "CI Bastion"

#   resources {
#     cores         = 2
#     memory        = 2
#     core_fraction = 20
#   }

#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.ci__debian.id
#       size     = 10
#     }
#   }

#   network_interface {
#     nat                = true
#     subnet_id          = yandex_vpc_subnet.vpc__subnet_public_a.id
#     security_group_ids = [yandex_vpc_security_group.sg__bastion.id]
#   }

#   scheduling_policy {
#     preemptible = true
#   }

#   metadata = {
#     ssh-keys  = "debian:${tls_private_key.tls__bastion_key.public_key_openssh}"
#     user-data = templatefile("templates/bastion.ci.tftpl", { pkgs = [] })
#   }

#   labels = {
#     role = "bastion"
#   }
# }
