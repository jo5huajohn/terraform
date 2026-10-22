resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve01"
  overwrite    = true

  source_raw {
    data = <<-EOF
    #cloud-config
    timezone: ${var.time_zone}
    users:
      - name: ${var.virtual_environment_vm_username}
        shell: /bin/bash
        groups:
          - sudo
        sudo: ALL=(ALL) NOPASSWD:ALL
        lock_passwd: true
        ssh_authorized_keys:
          - ${var.ssh_public_key}
    package_update: true
    packages:
      - curl
      - qemu-guest-agent
    runcmd:
      - systemctl enable --now qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_file" "infisical_meta_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve01"

  source_raw {
    data = <<-EOF
    #cloud-config
    local-hostname: infisical
    EOF

    file_name = "infisical-meta-data.yaml"
  }
}
