resource "yandex_lb_target_group" "lb__kubernetes_masters" {
  name      = "lb--kubernetes-masters"
  region_id = "ru-central1"

  target {
    subnet_id = data.terraform_remote_state.network.outputs.vpc__subnet_private_a_id
    address   = yandex_compute_instance.ci__kubernetes[local.ci__kubernetes_names.ci__master_a].network_interface[0].ip_address
  }

  target {
    subnet_id = data.terraform_remote_state.network.outputs.vpc__subnet_private_b_id
    address   = yandex_compute_instance.ci__kubernetes[local.ci__kubernetes_names.ci__master_b].network_interface[0].ip_address
  }
}

resource "yandex_lb_network_load_balancer" "lb__kubernetes_api" {
  name = "lb--kubernetes-api"
  type = "external"

  listener {
    name        = "kubernetes-api"
    protocol    = "tcp"
    port        = 6443
    target_port = 6443

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lb__kubernetes_masters.id

    healthcheck {
      name                = "lb--kubernetes-api-health"
      interval            = 2
      timeout             = 1
      unhealthy_threshold = 2
      healthy_threshold   = 2

      tcp_options {
        port = 6443
      }
    }
  }
}
