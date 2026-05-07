output "vpc__subnet_public_a_id" {
  value = yandex_vpc_subnet.vpc__subnet_public_a.id
}

output "vpc__subnet_public_b_id" {
  value = yandex_vpc_subnet.vpc__subnet_public_b.id
}

output "vpc__subnet_private_a_id" {
  value = yandex_vpc_subnet.vpc__subnet_private_a.id
}

output "vpc__subnet_private_b_id" {
  value = yandex_vpc_subnet.vpc__subnet_private_b.id
}

# ---

output "ci__bastion_name" {
  value = yandex_compute_instance.ci__bastion.name
}

output "ci__bastion_public_ip" {
  value     = yandex_compute_instance.ci__bastion.network_interface[0].nat_ip_address
  sensitive = true
}

# ---

output "tls__bastion_private_key" {
  value     = tls_private_key.tls__bastion_key.private_key_openssh
  sensitive = true
}
