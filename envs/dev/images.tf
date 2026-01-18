resource "proxmox_virtual_environment_download_file" "dev_fedora_cloud_43_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve01"
  url          = "https://download.fedoraproject.org/pub/fedora/linux/releases/43/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-43-1.6.x86_64.qcow2"
}
