output "vpc__network_id" {
  value     = yandex_vpc_network.vpc__network.id
  sensitive = true
}

output "vpc__subnet_public_a_id" {
  value     = yandex_vpc_subnet.vpc__subnet_public_a.id
  sensitive = true
}

output "vpc__subnet_public_a_v4_cidr_blocks" {
  value     = yandex_vpc_subnet.vpc__subnet_public_a.v4_cidr_blocks
  sensitive = true
}

output "vpc__subnet_public_b_id" {
  value     = yandex_vpc_subnet.vpc__subnet_public_b.id
  sensitive = true
}

output "vpc__subnet_public_b_v4_cidr_blocks" {
  value     = yandex_vpc_subnet.vpc__subnet_public_b.v4_cidr_blocks
  sensitive = true
}

output "vpc__subnet_private_a_id" {
  value     = yandex_vpc_subnet.vpc__subnet_private_a.id
  sensitive = true
}

output "vpc__subnet_private_a_v4_cidr_blocks" {
  value     = yandex_vpc_subnet.vpc__subnet_private_a.v4_cidr_blocks
  sensitive = true
}

output "vpc__subnet_private_b_id" {
  value     = yandex_vpc_subnet.vpc__subnet_private_b.id
  sensitive = true
}

output "vpc__subnet_private_b_v4_cidr_blocks" {
  value     = yandex_vpc_subnet.vpc__subnet_private_b.v4_cidr_blocks
  sensitive = true
}

output "ci__bastion_name" {
  value = yandex_compute_instance.ci__bastion.name
}

output "ci__bastion_public_ip" {
  value     = yandex_compute_instance.ci__bastion.network_interface[0].nat_ip_address
  sensitive = true
}

output "ls__bastion_ssh_key_id" {
  value     = yandex_lockbox_secret.ls__bastion_ssh_key.id
  sensitive = true
}
