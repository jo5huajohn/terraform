data "local_file" "ssh_public_key" {
  filename = "./reseau.pub"
}

resource "proxmox_virtual_environment_vm" "immich_vm" {
  name      = "immich"
  node_name = "pve01"

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
    }
  }

  memory {
    dedicated = 6144
  }

  network_device {
    bridge      = "vmbr0"
    mac_address = "BC:24:11:80:EF:3E"
  }

}

resource "proxmox_virtual_environment_vm" "mealie_vm" {
  name      = "mealie"
  node_name = "pve01"

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_noble_cloud_image_template.id
  }

  initialization {
    datastore_id = "vms"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  memory {
    dedicated = 4096
  }

  network_device {
    bridge      = "vmbr0"
    mac_address = "BC:24:11:91:3D:3A"
  }

}

resource "proxmox_virtual_environment_container" "nextcloud_container" {
  node_name = "pve01"
  
  cpu {
    cores = 2
  }

  disk {
    datastore_id = "vms"
    size         = 20
  }

  initialization {
    hostname = "nextcloud"
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
    dedicated = 6144
  }

  mount_point {
    backup = true
    volume = "pve1"
    path   = "/srv/nextcloud"
    size   = "128G"
  }

  network_interface {
    name        = "veth0"
    mac_address = "BC:24:11:50:65:8C"
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

resource "proxmox_virtual_environment_container" "paperless_ngx_container" {
  node_name = "pve01"
  
  cpu {
    cores = 2
  }

  disk {
    datastore_id = "vms"
    size         = 20
  }

  initialization {
    hostname = "paperless-ngx"
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
    dedicated = 4096
  }

  mount_point {
    backup = true
    volume = "pve1"
    path   = "/mnt/paperless-ngx"
    size   = "64G"
  }

  network_interface {
    name        = "veth0"
    mac_address = "BC:24:11:0B:1A:05"
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

