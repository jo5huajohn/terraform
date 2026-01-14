resource "proxmox_virtual_environment_acme_dns_plugin" "acme_cf" {
  plugin = "cloudflare-dns-lab42"
  api    = "cf"
  data = {
    CF_Account_ID = var.acme_dns_cf_account_id
    CF_Email      = var.acme_dns_cf_email
    CF_Token      = var.acme_dns_cf_token
    CF_Zone_ID    = var.acme_dns_cf_zone_id
  }
}

resource "proxmox_virtual_environment_time" "pve01_time" {
  node_name = "pve01"
  time_zone = "America/Chicago"
}
