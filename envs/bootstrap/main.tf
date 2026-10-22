resource "proxmox_virtual_environment_vm" "infisical_vm" {
  name      = "infisical"
  node_name = "pve01"
  tags      = [ "infra", "bootstrap", "terraform" ]

  stop_on_destroy = true

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "host"
  }

  disk {
    datastore_id = "vms"
    import_from  = proxmox_download_file.ubuntu_resolute_cloud_image.id
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = 128
    ssd          = true
  }

  efi_disk {
    datastore_id      = "vms"
    type              = "4m"
    pre_enrolled_keys = false
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

    meta_data_file_id = proxmox_virtual_environment_file.infisical_meta_data.id
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  memory {
    dedicated = 4096
  }

  network_device {
    bridge = "vmbr0"
  }
}
