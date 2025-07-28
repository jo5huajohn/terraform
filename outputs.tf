output "immich_ipv4_address" {
  value = proxmox_virtual_environment_vm.immich_vm.ipv4_addresses[1][0]
}

# output "seafile_ipv4_address" {
#   value = proxmox_virtual_environment_vm.seafile_vm.ipv4_addresses[1][0]
# }
