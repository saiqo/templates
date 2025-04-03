terraform {
    required_providers {
        proxmox = {
            source = "bpg/proxmox"
            version = "0.73.2"
        }
    }
}

provider "proxmox" {
  endpoint = var.pm_url
  api_token = var.pm_api_token
  insecure = true
  ssh {
    agent    = true
    username = "terraform"
  }
}
