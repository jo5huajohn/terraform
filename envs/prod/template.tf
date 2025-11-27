resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve01"
  overwrite    = true

  source_file {
    path = "./cloud-config.yml"
  }
}

resource "proxmox_virtual_environment_vm" "ubuntu_noble_cloud_image_template" {
  name      = "ubuntu-noble-template"
  node_name = "pve01"

  template        = true
  started         = false
  stop_on_destroy = true

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"

  agent {
    enabled = true
  }

  cpu {
    cores = 1
  }

  disk {
    datastore_id = "vms"
    import_from  = proxmox_virtual_environment_download_file.ubuntu_noble_cloud_image.id
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = 20
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
    }
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  memory {
    dedicated = 2048
  }

  serial_device {
    device = "socket"
  }

}

resource "proxmox_virtual_environment_container" "debian_bookworm_lxc_template" {
  node_name = "pve01"

  template = true
  started  = false

  cpu {
    cores = 1
  }

  disk {
    datastore_id = "vms"
    size         = 20
  }

  initialization {
    hostname = "debian-bookworm-template"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_account {
      keys = [
        trimspace(data.local_file.ssh_public_key.content)
      ]
      password = "4452218"
    }
  }

  memory {
    dedicated = 1024
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
    type             = "debian"
  }

  unprivileged = true

  features {
    nesting = true
  }

}
