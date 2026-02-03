output "immich_ipv4_address" {
  value = proxmox_virtual_environment_vm.immich_vm.ipv4_addresses[1][0]
}
