output "immich_ipv4_address" {
  value = proxmox_virtual_environment_vm.immich_vm.ipv4_addresses[1][0]
}

output "mealie_ipv4_address" {
  value = proxmox_virtual_environment_vm.mealie_vm.ipv4_addresses[1][0]
}

output "nextcloud_ipv4_address" {
  value = proxmox_virtual_environment_container.nextcloud_container.ipv4.veth0
}

output "paperless_ngx_ipv4_address" {
  value = proxmox_virtual_environment_container.paperless_ngx_container.ipv4.veth0
}
