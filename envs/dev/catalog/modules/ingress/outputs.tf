output "ingress_ipv4_address" {
  value = proxmox_virtual_environment_container.ingress.ipv4.veth0
}
