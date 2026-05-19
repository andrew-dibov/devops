# Virtual Private Cloud : Network

resource "yandex_vpc_network" "vpc__network" {
  name        = var.vpc__network_name
  description = var.vpc__network_description
}

# Virtual Private Cloud : Subnet

resource "yandex_vpc_subnet" "vpc__subnet_public_a" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = var.vpc__subnet_public_a_name
  description = var.vpc__subnet_public_a_description

  zone           = var.vpc__subnet_public_a_zone
  v4_cidr_blocks = var.vpc__subnet_public_a_cidr
}

resource "yandex_vpc_subnet" "vpc__subnet_public_b" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = var.vpc__subnet_public_b_name
  description = var.vpc__subnet_public_b_description

  zone           = var.vpc__subnet_public_b_zone
  v4_cidr_blocks = var.vpc__subnet_public_b_cidr
}

resource "yandex_vpc_subnet" "vpc__subnet_private_a" {
  network_id     = yandex_vpc_network.vpc__network.id
  route_table_id = yandex_vpc_route_table.vpc__route_table.id

  name        = var.vpc__subnet_private_a_name
  description = var.vpc__subnet_private_a_description

  zone           = var.vpc__subnet_private_a_zone
  v4_cidr_blocks = var.vpc__subnet_private_a_cidr
}

resource "yandex_vpc_subnet" "vpc__subnet_private_b" {
  network_id     = yandex_vpc_network.vpc__network.id
  route_table_id = yandex_vpc_route_table.vpc__route_table.id

  name        = var.vpc__subnet_private_b_name
  description = var.vpc__subnet_private_b_description

  zone           = var.vpc__subnet_private_b_zone
  v4_cidr_blocks = var.vpc__subnet_private_b_cidr
}

# Virtual Private Cloud : Route Table

resource "yandex_vpc_route_table" "vpc__route_table" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = var.vpc__route_table_name
  description = var.vpc__route_table_description

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.vpc__gateway.id
  }
}

# Virtual Private Cloud : Gateway

resource "yandex_vpc_gateway" "vpc__gateway" {
  name        = var.vpc__gateway_name
  description = var.vpc__gateway_description

  shared_egress_gateway {}
}

# Virtual Private Cloud : Security Group : Bastion

resource "yandex_vpc_security_group" "sg__bastion" {
  network_id = yandex_vpc_network.vpc__network.id

  name        = var.sg__bastion_name
  description = var.sg__bastion_description

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "SSH"
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
