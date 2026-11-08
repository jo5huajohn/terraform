resource "proxmox_acme_dns_plugin" "acme_cf" {
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
  time_zone = var.time_zone
}

resource "system_file" "zpool_scrub_service" {
  path    = "/etc/systemd/system/zpool-scrub.service"
  mode    = 644
  user    = "root"
  group   = "root"
  content = <<EOT
[Unit]
Description=ZFS Pool Scrub

[Service]
Type=oneshot
ExecStart=/usr/sbin/zpool scrub pve1
EOT
}

resource "system_file" "zpool_scrub_timer" {
  path    = "/etc/systemd/system/zpool-scrub.timer"
  mode    = 644
  user    = "root"
  group   = "root"
  content = <<EOT
[Unit]
Description=Weekly ZFS Pool Scrub

[Timer]
OnCalendar=Sun *-*-* 02:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOT
}

resource "system_systemd_unit" "zpool_scrub" {
  name    = "zpool-scrub"
  type    = "timer"
  enabled = true
  status  = "started"

  depends_on = [
    system_file.zpool_scrub_service,
    system_file.zpool_scrub_timer
  ]
}
