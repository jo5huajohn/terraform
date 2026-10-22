resource "proxmox_download_file" "ubuntu_resolute_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve01"
  url          = "https://cloud-images.ubuntu.com/resolute/current/resolute-server-cloudimg-amd64.img"
  file_name    = "resolute-server-cloudimg-amd64.qcow2"
}
