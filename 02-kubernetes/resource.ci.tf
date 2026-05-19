# Compute Instance : Kubernetes

resource "yandex_compute_instance" "ci__kubernetes" {
  for_each = local.ci__kubernetes_configs

  zone        = each.value.zone
  platform_id = var.ci__kubernetes_platform_id

  name        = each.key
  hostname    = each.key
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
    user-data = templatefile("${var.templates_dir}/cloud-init.common.tftpl", { pkgs = ["python3"] })
  }

  labels = {
    role = each.value.role
  }
}

# Local File : Ansible Config

resource "local_file" "lf__ansible_config" {
  filename = var.lf__ansible_config_filename
  content  = templatefile("${var.templates_dir}/ansible.cfg.tftpl", {})
}

# Local File : Ansible Inventory

resource "local_file" "lf__ansible_inventory" {
  filename = var.lf__ansible_inventory_filename
  content = templatefile("${var.templates_dir}/ansible.inventory.tftpl", {
    instances = yandex_compute_instance.ci__kubernetes
  })
}

# Local File : Ansible Variables

resource "local_file" "lf__ansible_variables" {
  filename = var.lf__ansible_variables_filename
  content = templatefile("${var.templates_dir}/ansible.variables.tftpl", {
    master_a = yandex_compute_instance.ci__kubernetes["${local.ci__kubernetes_names.ci__master_a}"].network_interface[0].ip_address
    master_b = yandex_compute_instance.ci__kubernetes["${local.ci__kubernetes_names.ci__master_b}"].network_interface[0].ip_address
    worker_a = yandex_compute_instance.ci__kubernetes["${local.ci__kubernetes_names.ci__worker_a}"].network_interface[0].ip_address
    worker_b = yandex_compute_instance.ci__kubernetes["${local.ci__kubernetes_names.ci__worker_b}"].network_interface[0].ip_address

    control_plane_endpoint = tolist([
      for l in yandex_lb_network_load_balancer.lb__kubernetes_api.listener :
      tolist(l.external_address_spec)[0].address
    ])[0]
  })
}
