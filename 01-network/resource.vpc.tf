resource "yandex_vpc_network" "vpc__network" {
  name        = "vpc--network"
  description = "VPC Network"
}

resource "yandex_vpc_subnet" "vpc__subnet_public_a" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = "vpc--subnet-public-a"
  description = "VPC Subnet Public A"

  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "vpc__subnet_public_b" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = "vpc--subnet-public-b"
  description = "VPC Subnet Public B"

  zone           = "ru-central1-b"
  v4_cidr_blocks = ["10.0.2.0/24"]
}

resource "yandex_vpc_subnet" "vpc__subnet_private_a" {
  network_id     = yandex_vpc_network.vpc__network.id
  route_table_id = yandex_vpc_route_table.vpc__route_table.id

  name        = "vpc--subnet-private-a"
  description = "VPC Subnet Private A"

  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.1.1.0/24"]
}

resource "yandex_vpc_subnet" "vpc__subnet_private_b" {
  network_id     = yandex_vpc_network.vpc__network.id
  route_table_id = yandex_vpc_route_table.vpc__route_table.id

  name        = "vpc--subnet-private-b"
  description = "VPC Subnet Private B"

  zone           = "ru-central1-b"
  v4_cidr_blocks = ["10.1.2.0/24"]
}

# ---

resource "yandex_vpc_route_table" "vpc__route_table" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = "vpc--route-table"
  description = "VPC Route Table"

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.vpc__gateway.id
  }
}

resource "yandex_vpc_gateway" "vpc__gateway" {
  name        = "vpc--gateway"
  description = "VPC Gateway"

  shared_egress_gateway {}
}

# ---

resource "yandex_vpc_security_group" "sg__bastion" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = "sg--bastion"
  description = "SG Bastion"

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "SSH to Private"
    v4_cidr_blocks = ["10.0.0.0/12"]
    port           = 22
  }

  egress {
    protocol       = "UDP"
    description    = "DNS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 53
  }

  egress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}
