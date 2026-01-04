resource "proxmox_virtual_environment_container" "traefik" {
  node_name = "pve01"
  tags      = [ "infra", "dev" ]

  cpu {
    cores = 1
  }

  disk {
    datastore_id = "vms"
    size         = 20
  }

  initialization {
    hostname = "traefik"

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
        trimspace(var.ssh_pub_key)
      ]
      password = var.virtual_environment_user_account_password
    }
  }

  memory {
    dedicated = 1024
  }

  network_interface {
    name        = "veth0"
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    type             = "debian"
  }

  unprivileged = true

  features {
    nesting = true
  }
}
