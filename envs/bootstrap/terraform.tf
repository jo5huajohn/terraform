terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.117.0"
    }
    system = {
      source  = "neuspaces/system"
      version = "0.5.0"
    }
  }
}
