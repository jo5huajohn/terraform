output "traefik_ipv4_address" {
  value = proxmox_virtual_environment_container.traefik.ipv4.veth0
}