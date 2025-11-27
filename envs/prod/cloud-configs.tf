resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve01"
  overwrite    = true

  source_file {
    path = "./cloud-config.yml"
  }
}

resource "proxmox_virtual_environment_file" "k8s_user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve01"

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: k8s-node
    timezone: America/Chicago
    allow_public_ssh_keys: true
    users:
      - default
      - name: admin
        sudo: ALL=(ALL) NOPASSWD:ALL
        groups:
          - wheel
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_pub_key.content)}
    package_update: true
    runcmd:
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "k8s-user-data-cloud-config.yaml"
  }
}
