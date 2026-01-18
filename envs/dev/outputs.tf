output "traefik_ipv4_address" {
  value = proxmox_virtual_environment_container.traefik.ipv4.veth0
}

output "vault_ipv4_address" {
  value = proxmox_virtual_environment_vm.vault.ipv4_addresses[1][0]
}
