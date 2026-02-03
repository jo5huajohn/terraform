terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.90.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name         = var.name
  node_name    = var.node_name
  tags         = var.tags

  on_boot         = var.on_boot
  stop_on_destroy = var.stop_on_destroy

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"

  agent {
    enabled = true
  }

  cpu {
    cores = var.cores
    type  = var.cpu_type
  }

  disk {
    datastore_id = var.disk_storage
    import_from  = var.image_id
    interface    = var.disk_interface
    iothread     = var.iothread
    discard      = var.discard
    size         = var.disk_size
    ssd          = var.ssd
  }

  efi_disk {
    datastore_id      = var.disk_storage
    type              = "4m"
    pre_enrolled_keys = true
  }

  initialization {
    datastore_id      = var.disk_storage

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
        trimspace(var.user_ssh_key_public)
      ]
      username = var.username
    }
  }

  memory {
    dedicated = var.memory
  }

  network_device {
    bridge = var.network_bridge
  }

  operating_system {
    type             = "l26"
  }
}
