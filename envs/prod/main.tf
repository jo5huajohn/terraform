resource "proxmox_virtual_environment_vm" "haos_vm" {
  name      = "homeassistant"
  node_name = "pve01"
  tags      = [ "app", "prod", "terraform" ]

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
    import_from  = "local:import/haos_ova-18.1.qcow2"
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

    user_account {
      keys     = [trimspace(var.ssh_pub_key)]
      username = var.virtual_environment_vm_username
    }
  }

  memory {
    dedicated = 2048
    floating  = 2048
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "other"
  }

  serial_device {
    device = "socket"
  }

   usb {
    host    = "1-14"
    usb3    = true
  }
}

resource "proxmox_virtual_environment_vm" "immich_vm" {
  name      = "immich"
  node_name = "pve01"
  tags      = [ "app", "prod" ]

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_noble_cloud_image_template.id
  }

  cpu {
    cores = 3
    type  = "host"
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
