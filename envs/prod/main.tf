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
      ipv6 {
        address = "auto"
      }
    }
  }

  memory {
    dedicated = 4096
  }

  network_interface {
    name        = "veth0"
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
      ipv6 {
        address = "auto"
      }
    }
  }

  network_interface {
    name        = "veth0"
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
      ipv6 {
        address = "auto"
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
  }
}

locals {
  workers = {
    "virt-w01" = {
      ip_address  = "10.42.20.30/24"
      gateway     = "10.42.20.1"
      dns_servers = [ "10.42.10.1" ]
    }
    "virt-w02" = {
      ip_address  = "10.42.20.31/24"
      gateway    = "10.42.20.1"
      dns_servers = [ "10.42.10.1" ]
    }
  }
}

resource "proxmox_virtual_environment_file" "k8s_meta_data_cloud_config" {
  for_each     = local.workers
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve01"

  source_raw {
    data = <<-EOF
    #cloud-config
    local-hostname: ${each.key}
    EOF

    file_name = "meta-data-cloud-config-${each.key}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "k8s-worker-dev" {
  for_each    = local.workers
  name        = each.key
  tags        = ["k8s", "k8s-worker", "dev"]
  node_name = "pve01"

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"

  agent {
    enabled = true
  }

  cpu {
    cores = 4
    type  = "x86-64-v2-AES"
  }

  disk {
    datastore_id = "vms"
    import_from  = proxmox_virtual_environment_download_file.fedora_cloud_43_cloud_image.id
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = 128
    ssd          = true
  }

  disk {
    datastore_id = "pve1"
    interface    = "scsi1"
    iothread     = true
    discard      = "on"
    size         = 128
  }
  efi_disk {
    datastore_id      = "vms"
    type              = "4m"
    pre_enrolled_keys = false
  }

  initialization {
    datastore_id = "vms"
    dns {
      servers = each.value.dns_servers
    }

    ip_config {
      ipv4 {
        address = each.value.ip_address
	      gateway = each.value.gateway
      }
    }

    user_account {
      keys     = [
        trimspace(var.ssh_pub_key)
      ]
      username = var.virtual_environment_vm_username
    }

    meta_data_file_id = proxmox_virtual_environment_file.k8s_meta_data_cloud_config[each.key].id
  }

  operating_system {
    type = "l26"
  }

  memory {
    dedicated = 4096
  }

  network_device {
    bridge = "vmbr0"
  }
}
