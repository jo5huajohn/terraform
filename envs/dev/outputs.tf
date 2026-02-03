output "pocket_id_ipv4_address" {
  value = module.pocket-id.container_ipv4_address.veth0
}

output "traefik_ipv4_address" {
  value = module.traefik.ingress_ipv4_address
}

output "vault_ipv4_address" {
  value = proxmox_virtual_environment_vm.vault.ipv4_addresses[1][0]
}

output "mealie_ipv4_address" {
  value = module.mealie.container_ipv4_address.veth0
}

output "paperless_ngx_ipv4_address" {
  value = module.paperless_ngx.container_ipv4_address.veth0
}
