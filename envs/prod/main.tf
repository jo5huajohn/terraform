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
    }
  }

  memory {
    dedicated = 8192
  }

  network_device {
    bridge      = "vmbr0"
    mac_address = "BC:24:11:80:EF:3E"
  }
}

resource "proxmox_virtual_environment_vm" "mealie_vm" {
  name      = "mealie"
  node_name = "pve01"
  tags      = [ "app", "prod" ]

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

resource "proxmox_virtual_environment_container" "authentik_container" {
  node_name = "pve01"
  tags      = [ "infra", "prod" ]

  clone {
   vm_id = proxmox_virtual_environment_container.debian_bookworm_lxc_template.id
  }

  cpu {
    cores = 2
  }

  initialization {
    hostname = "authentik"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  memory {
    dedicated = 4096
  }

  network_interface {
    name        = "veth0"
    mac_address = "BC:24:11:F7:C1:48"
  }
}

resource "proxmox_virtual_environment_container" "caddy_container" {
  node_name = "pve01"
  tags      = [ "infra", "prod" ]

  clone {
   vm_id = proxmox_virtual_environment_container.debian_bookworm_lxc_template.id
  }

  initialization {
    hostname = "caddy"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  network_interface {
    name        = "veth0"
    mac_address = "BC:24:11:89:4C:EE"
  }
}

resource "proxmox_virtual_environment_container" "nextcloud_container" {
  node_name = "pve01"
  tags      = [ "app", "prod" ]

  clone {
   vm_id = proxmox_virtual_environment_container.debian_bookworm_lxc_template.id
  }

  cpu {
    cores = 2
  }

  initialization {
    hostname = "nextcloud"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  memory {
    dedicated = 6144
  }

  mount_point {
    backup = true
    volume = "pve1"
    path   = "/mnt/ncdata"
    size   = "128G"
  }

  network_interface {
    name        = "veth0"
    mac_address = "BC:24:11:50:65:8C"
  }
}

resource "proxmox_virtual_environment_container" "paperless_ngx_container" {
  node_name = "pve01"
  tags      = [ "app", "prod" ]

  clone {
   vm_id = proxmox_virtual_environment_container.debian_bookworm_lxc_template.id
  }

  cpu {
    cores = 2
  }

  initialization {
    hostname = "paperless"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  memory {
    dedicated = 4096
  }

  mount_point {
    backup = true
    volume = "pve1"
    path   = "/mnt/paperless"
    size   = "64G"
  }

  network_interface {
    name        = "veth0"
    mac_address = "BC:24:11:0B:1A:05"
  }
}

