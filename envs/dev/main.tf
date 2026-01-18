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

resource "proxmox_virtual_environment_vm" "vault" {
  name      = "vault"
  node_name = "pve01"
  tags      = [ "infra", "dev" ]

  on_boot         = true
  stop_on_destroy = true

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  disk {
    datastore_id = "vms"
    import_from  = proxmox_virtual_environment_download_file.dev_fedora_cloud_43_image.id
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = 128
    ssd          = true
  }

  efi_disk {
    datastore_id      = "vms"
    type              = "4m"
    pre_enrolled_keys = true
  }

  initialization {
    datastore_id = "vms"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
      ipv6 {
        address = "auto"
      }
    }

    user_account {
      keys     = [
        trimspace(var.ssh_pub_key)
      ]
      username = var.virtual_environment_vm_username
    }
  }

  memory {
    dedicated = 4096
  }

  network_device {
    bridge      = "vmbr0"
  }

  operating_system {
    type = "l26"
  }
}
