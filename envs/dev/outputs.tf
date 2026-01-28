output "traefik_ipv4_address" {
  value = module.traefik.ingress_ipv4_address
}

output "vault_ipv4_address" {
  value = proxmox_virtual_environment_vm.vault.ipv4_addresses[1][0]
}
