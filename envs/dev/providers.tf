provider "proxmox" {
  endpoint  = "${var.virtual_environment_address}:8006"
  api_token = var.virtual_environment_api_token
}
