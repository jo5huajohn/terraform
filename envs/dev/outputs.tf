output "pocket_id_ipv4_address" {
  value = module.pocket-id.container_ipv4_address.veth0
}

output "traefik_ipv4_address" {
  value = module.traefik.ingress_ipv4_address.veth0
}

output "actual_ipv4_address" {
  value = module.actual_budget.container_ipv4_address.veth0
}

output "mealie_ipv4_address" {
  value = module.mealie.container_ipv4_address.veth0
}

output "opencloud_ipv4_address" {
  value = module.opencloud.container_ipv4_address.veth0
}

output "paperless_ngx_ipv4_address" {
  value = module.paperless_ngx.container_ipv4_address.veth0
}
