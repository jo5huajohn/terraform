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

module "actual_budget" {
  source = "../../catalog/modules/container"

  node_name = "pve01"
  tags      = [ "dev" , "app" ]

  cores  = 1
  memory = 512

  disk_storage = "vms"
  disk_size = 40

  hostname          = "actual"
  network_interface = "veth0"

  os_template_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
  os_type        = "debian"

  user_ssh_key_public = var.ssh_pub_key
  user_password       = var.virtual_environment_user_account_password
}
