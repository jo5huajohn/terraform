resource "proxmox_virtual_environment_vm" "immich_vm" {
  name      = "immich"
  node_name = "pve01"
  tags      = [ "app", "prod" ]

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_noble_cloud_image_template.id
  }

  cpu {
    cores = 3
  }

  disk {
    datastore_id = "pve1"
    interface    = "scsi1"
    iothread     = true
    discard      = "on"
    size         = 128
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

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  memory {
    dedicated = 8192
  }

  network_device {
    bridge      = "vmbr0"
  }
}
