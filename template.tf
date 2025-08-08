resource "proxmox_virtual_environment_download_file" "ubuntu_noble_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve01"
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}

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

  template = true
  started  = false

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

  network_device {
    bridge = "vmbr0"
  }

}
