resource "yandex_compute_instance" "ci__bastion" {
  zone        = yandex_vpc_subnet.vpc__subnet_public_a.zone
  platform_id = "standard-v3"

  name        = "ci--bastion"
  hostname    = "bastion"
  description = "CI Bastion"

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
    user-data = templatefile("templates/bastion.ci.tftpl", { pkgs = [] })
  }

  labels = {
    role = "bastion"
  }
}
