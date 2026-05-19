variable "templates_dir" {
  type    = string
  default = "templates"
}

variable "auth_dir" {
  type    = string
  default = ".auth"
}

# Compute Instance : Bastion

variable "ci__debian_family" {
  type    = string
  default = "debian-12"
}

variable "ci__bastion_platform_id" {
  type    = string
  default = "standard-v3"
}

variable "ci__bastion_name" {
  type    = string
  default = "ci--bastion"
}

variable "ci__bastion_hostname" {
  type    = string
  default = "bastion"
}

variable "ci__bastion_description" {
  type    = string
  default = "Compute instance Bastion"
}

variable "ci__bastion_role" {
  type    = string
  default = "bastion"
}

# Virtual Private Cloud : Network

variable "vpc__network_name" {
  type    = string
  default = "vpc--network"
}

variable "vpc__network_description" {
  type    = string
  default = "Virtual private cloud network"
}

# Virtual Private Cloud : Subnet

variable "vpc__subnet_public_a_name" {
  type    = string
  default = "vpc--subnet-public-a"
}

variable "vpc__subnet_public_a_description" {
  type    = string
  default = "Virtual private cloud subnet public A"
}

variable "vpc__subnet_public_a_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "vpc__subnet_public_a_cidr" {
  type    = tuple([string])
  default = ["10.0.1.0/24"]
}

variable "vpc__subnet_public_b_name" {
  type    = string
  default = "vpc--subnet-public-b"
}

variable "vpc__subnet_public_b_description" {
  type    = string
  default = "Virtual private cloud subnet public B"
}

variable "vpc__subnet_public_b_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "vpc__subnet_public_b_cidr" {
  type    = tuple([string])
  default = ["10.0.2.0/24"]
}

variable "vpc__subnet_private_a_name" {
  type    = string
  default = "vpc--subnet-private-a"
}

variable "vpc__subnet_private_a_description" {
  type    = string
  default = "Virtual private cloud subnet private A"
}

variable "vpc__subnet_private_a_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "vpc__subnet_private_a_cidr" {
  type    = tuple([string])
  default = ["10.1.1.0/24"]
}

variable "vpc__subnet_private_b_name" {
  type    = string
  default = "vpc--subnet-private-b"
}

variable "vpc__subnet_private_b_description" {
  type    = string
  default = "Virtual private cloud subnet private B"
}

variable "vpc__subnet_private_b_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "vpc__subnet_private_b_cidr" {
  type    = tuple([string])
  default = ["10.1.2.0/24"]
}

# Virtual Private Cloud : Route Table

variable "vpc__route_table_name" {
  type    = string
  default = "vpc--route-table"
}

variable "vpc__route_table_description" {
  type    = string
  default = "Virtual private cloud route table"
}

# Virtual Private Cloud : Gateway

variable "vpc__gateway_name" {
  type    = string
  default = "vpc--gateway"
}

variable "vpc__gateway_description" {
  type    = string
  default = "Virtual private cloud gateway"
}

# Virtual Private Cloud : Security Group

variable "sg__bastion_name" {
  type    = string
  default = "sg--bastion"
}

variable "sg__bastion_description" {
  type    = string
  default = "Security group for Bastion"
}

# Lockbox Secret

variable "ls__bastion_ssh_key_name" {
  type    = string
  default = "ls--bastion-ssh-key"
}
