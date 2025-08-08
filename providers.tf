provider "proxmox" {
  endpoint  = "https://${var.virtual_environment_ip}:8006/"
  api_token = var.virtual_environment_api_token
  insecure  = true
  ssh {
    agent    = true
    username = "root"
    node {
      name    = "pve01"
      address = var.virtual_environment_ip
    }
  }
}
