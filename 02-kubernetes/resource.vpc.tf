# Virtual Private Cloud : Security Group : Kubernetes

resource "yandex_vpc_security_group" "sg__kubernetes" {
  network_id = data.terraform_remote_state.network.outputs.vpc__network_id

  name        = var.sg__kubernetes_name
  description = var.sg__kubernetes_description

  ingress {
    protocol       = "TCP"
    description    = "Kubernetes API LB"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }

  ingress {
    protocol       = "TCP"
    description    = "NodePort from LB"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 30080
  }

  ingress {
    protocol       = "TCP"
    description    = "NodePort from LB"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 30443
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP from LB"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS from LB"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol    = "TCP"
    description = "SSH"
    v4_cidr_blocks = [
      data.terraform_remote_state.network.outputs.vpc__subnet_public_a_v4_cidr_blocks[0],
      data.terraform_remote_state.network.outputs.vpc__subnet_public_b_v4_cidr_blocks[0],
    ]
    port = 22
  }

  ingress {
    protocol    = "ANY"
    description = "Internal Cluster"
    v4_cidr_blocks = [
      data.terraform_remote_state.network.outputs.vpc__subnet_private_a_v4_cidr_blocks[0],
      data.terraform_remote_state.network.outputs.vpc__subnet_private_b_v4_cidr_blocks[0],
    ]
  }

  egress {
    protocol       = "ANY"
    description    = "Egress via NAT"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "ANY"
    description = "Internal Cluster"
    v4_cidr_blocks = [
      data.terraform_remote_state.network.outputs.vpc__subnet_private_a_v4_cidr_blocks[0],
      data.terraform_remote_state.network.outputs.vpc__subnet_private_b_v4_cidr_blocks[0],
    ]
  }
}
