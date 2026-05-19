# Compute Instance : Bastion

resource "yandex_compute_instance" "ci__bastion" {
  zone        = yandex_vpc_subnet.vpc__subnet_public_a.zone
  platform_id = var.ci__bastion_platform_id

  name        = var.ci__bastion_name
  hostname    = var.ci__bastion_hostname
  description = var.ci__bastion_description

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ci__debian.id
      size     = 10
    }
  }

  network_interface {
    nat                = true
    subnet_id          = yandex_vpc_subnet.vpc__subnet_public_a.id
    security_group_ids = [yandex_vpc_security_group.sg__bastion.id]
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys  = "debian:${tls_private_key.tls__bastion_key.public_key_openssh}"
    user-data = templatefile("${var.templates_dir}/bastion.ci.tftpl", { pkgs = [] })
  }

  labels = {
    role = var.ci__bastion_role
  }
}
