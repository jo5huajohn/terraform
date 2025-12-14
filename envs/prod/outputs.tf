output "immich_ipv4_address" {
  value = proxmox_virtual_environment_vm.immich_vm.ipv4_addresses[1][0]
}

output "mealie_ipv4_address" {
  value = proxmox_virtual_environment_vm.mealie_vm.ipv4_addresses[1][0]
}

output "vault_ipv4_address" {
  value = proxmox_virtual_environment_vm.vault_vm.ipv4_addresses[1][0]
}
