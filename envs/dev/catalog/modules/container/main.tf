terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.90.0"
    }
  }
}

resource "proxmox_virtual_environment_container" "container" {
  node_name    = var.node_name
  unprivileged = true

  tags = var.tags

  cpu {
    cores = var.cores
  }

  disk {
    datastore_id = var.disk_storage
    size         = var.disk_size
  }

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = "dhcp"
      }
      ipv6 {
        address = "auto"
      }
    }

    user_account {
      keys = [
        trimspace(var.user_ssh_key_public)
      ]
      password = var.user_password
    }
  }

  memory {
    dedicated = var.memory
  }

  network_interface {
    name = var.network_interface
  }

  operating_system {
    template_file_id = var.os_template_id
    type             = var.os_type
  }

  features {
    nesting = true
  }
}
