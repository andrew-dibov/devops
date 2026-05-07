terraform {
  required_version = ">= 1.14.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.174.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.6.1"
    }
  }
}

provider "yandex" {
}
