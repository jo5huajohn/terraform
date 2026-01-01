resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve01"
  overwrite    = true

  source_file {
    path = "./cloud-config.yml"
  }
}

