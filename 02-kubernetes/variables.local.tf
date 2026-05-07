locals {
  ci__names = {
    ci__master_a = "ci--master-a"
    ci__master_b = "ci--master-b"
    ci__worker_a = "ci--worker-a"
    ci__worker_b = "ci--worker-b"
  }
  ci__configs = {
    (local.ci__names.ci__master_a) = {
      zone = "ru-central1-a"

      hostname    = "master-a"
      description = "CI K8s Master A"

      resources = {
        cores         = 4
        memory        = 4
        core_fraction = 20
      }

      initialize_params = {
        size = 40
      }

      network_interface = {
        subnet_id          = data.terraform_remote_state.network.outputs.vpc__subnet_private_a_id
        nat                = false
        security_group_ids = []
      }

      scheduling_policy = {
        preemptible = true
      }

      role = "master-a"
    }
    (local.ci__names.ci__master_b) = {
      zone = "ru-central1-b"

      hostname = "master-b"
      description = "CI K8s Master B"

      resources = {
        cores = 4
        memory = 4
        core_fraction = 20
      }

      initialize_params = {
        size = 40
      }

      network_interface = {
        subnet_id = data.terraform_remote_state.network.outputs.vpc__subnet_private_b_id
        nat = false
        security_group_ids = []
      }

      scheduling_policy = {
        preemptible = true
      }

      role = "master-b"
    }
    (local.ci__names.ci__worker_a) = {
      zone = "ru-central1-a"

      hostname = "worker-a"
      description = "CI K8s Worker A"

      resources = {
        cores = 4
        memory = 4
        core_fraction = 20
      }

      initialize_params = {
        size = 40
      }

      network_interface = {
        subnet_id = data.terraform_remote_state.network.outputs.vpc__subnet_private_a_id
        nat = false
        security_group_ids = []
      }

      scheduling_policy = {
        preemptible = true
      }

      role = "worker-a"
    }
    (local.ci__names.ci__worker_b) = {
      zone = "ru-central1-b"

      hostname = "worker-b"
      description = "CI K8s Worker B"

      resources = {
        cores = 4
        memory = 4
        core_fraction = 20
      }

      initialize_params = {
        size = 40
      }

      network_interface = {
        subnet_id = data.terraform_remote_state.network.outputs.vpc__subnet_private_b_id
        nat = false
        security_group_ids = []
      }

      scheduling_policy = {
        preemptible = true
      }

      role = "worker-b"
    }
  }
}
