variable "templates_dir" {
  type    = string
  default = "templates"
}

variable "auth_dir" {
  type    = string
  default = "ansible/.auth"
}

# Compute Instance : Kubernetes

variable "ci__debian_family" {
  type    = string
  default = "debian-12"
}

variable "ci__kubernetes_platform_id" {
  type    = string
  default = "standard-v3"
}

# Local File : Ansible Config

variable "lf__ansible_config_filename" {
  type    = string
  default = "ansible/ansible.cfg"
}

# Local File : Ansible Inventory

variable "lf__ansible_inventory_filename" {
  type    = string
  default = "ansible/inventory/terraform.yml"
}

# Local File : Ansible Variables

variable "lf__ansible_variables_filename" {
  type    = string
  default = "ansible/variables/terraform.yml"
}

# Local File : SSH Config

variable "lf__ssh_config_filename" {
  type    = string
  default = "ansible/ssh-config"
}

# Load Balancer : Target Group : API

variable "lb__target_group_kubernetes_masters_name" {
  type    = string
  default = "lb--kubernetes-masters"
}

variable "lb__target_group_kubernetes_masters_region_id" {
  type    = string
  default = "ru-central1"
}

# Load Balancer : Target Group : Ingress

variable "lb__target_group_kubernetes_ingress_name" {
  type    = string
  default = "lb--kubernetes-ingress"
}

variable "lb__target_group_kubernetes_ingress_region_id" {
  type    = string
  default = "ru-central1"
}

# Load Balancer : API

variable "lb__kubernetes_api_name" {
  type    = string
  default = "lb--kubernetes-api"
}

variable "lb__kubernetes_api_type" {
  type    = string
  default = "external"
}

variable "lb__kubernetes_api_listener_name" {
  type    = string
  default = "kubernetes-api"
}

variable "lb__kubernetes_api_healthcheck_name" {
  type    = string
  default = "lb--kubernetes-api-health"
}

# Load Balancer : Ingress

variable "lb__kubernetes_ingress_name" {
  type    = string
  default = "lb--kubernetes-ingress"
}

variable "lb__kubernetes_ingress_type" {
  type    = string
  default = "external"
}

variable "lb__kubernetes_ingress_listener_name_http" {
  type    = string
  default = "http-listener"
}

variable "lb__kubernetes_ingress_listener_name_https" {
  type    = string
  default = "https-listener"
}

variable "lb__kubernetes_ingress_healthcheck_name" {
  type    = string
  default = "lb--kubernetes-ingress-health"
}

# Security Group : Kubernetes

variable "sg__kubernetes_name" {
  type    = string
  default = "sg--kubernetes"
}

variable "sg__kubernetes_description" {
  type    = string
  default = "Security group for Kubernetes"
}
