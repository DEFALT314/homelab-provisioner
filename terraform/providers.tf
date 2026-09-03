terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.111"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://192.168.1.254:8006/"
  api_token = var.proxmox_token
  insecure  = true
  ssh {
    agent    = true
    username = "root"
  }
}