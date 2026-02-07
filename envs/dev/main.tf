module "pocket-id" {
  source = "../../catalog/modules/container"

  node_name = "pve01"
  tags      = [ "dev", "infra" ]

  disk_storage = "vms"

  hostname          = "pocket-id"
  network_interface = "veth0"

  os_template_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
  os_type        = "debian"

  user_ssh_key_public = var.ssh_pub_key
  user_password       = var.virtual_environment_user_account_password
}

module "traefik" {
  source = "../../catalog/modules/ingress"

  node_name = "pve01"
  tags = [ "dev", "infra" ]

  disk_storage = "vms"

  hostname = "traefik"
  network_interface = "veth0"

  user_ssh_key_public = var.ssh_pub_key
  user_password = var.virtual_environment_user_account_password
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

module "mealie" {
  source = "../../catalog/modules/container"

  node_name = "pve01"
  tags      = [ "dev", "app" ]

  memory = 4096

  disk_storage = "vms"
  disk_size    = 40

  hostname          = "mealie"
  network_interface = "veth0"

  os_template_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
  os_type        = "debian"

  user_ssh_key_public = var.ssh_pub_key
  user_password       = var.virtual_environment_user_account_password
}

module "opencloud" {
  source = "../../catalog/modules/container"

  node_name = "pve01"
  tags      = [ "dev", "app" ]

  cores  = 2
  memory = 4096

  disk_storage = "vms"

  mountpoint = [
    {
      mp_volume = "pve1"
      mp_size   = "128G"
      mp_path   = "/mnt/opencloud"
      mp_backup = true
    }
  ]

  hostname          = "opencloud"
  network_interface = "veth0"

  os_template_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
  os_type        = "debian"

  user_ssh_key_public = var.ssh_pub_key
  user_password       = var.virtual_environment_user_account_password
}

module "paperless_ngx" {
  source = "../../catalog/modules/container"

  node_name = "pve01"
  tags      = [ "dev", "app" ]

  cores  = 2
  memory = 4096

  disk_storage = "vms"

  mountpoint = [
    {
      mp_volume = "pve1"
      mp_size   = "64G"
      mp_path   = "/mnt/paperless"
      mp_backup = true
    }
  ]

  hostname          = "paperless"
  network_interface = "veth0"

  os_template_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
  os_type        = "debian"

  user_ssh_key_public = var.ssh_pub_key
  user_password       = var.virtual_environment_user_account_password
}
