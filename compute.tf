data "local_file" "ssh_public_key" {
  filename = "./reseau.pub"
} 

resource "proxmox_virtual_environment_download_file" "ubuntu_noble_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = "https://cloud-images.ubuntu.com/minimal/releases/noble/release/ubuntu-24.04-minimal-cloudimg-amd64.img"
  file_name    = "noble-minimal-cloudimg-amd64.qcow2"
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname = "ubuntu"
    timezone: America/Chicago
    users:
      - default
      - name: admin
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "immich_vm" {
  name      = "immich-vm"
  node_name = "pve"

  started  = true

  machine = "q35"
  bios    = "ovmf"

  agent {
    enabled = true
  }

  cpu {
    cores = 3
  }

  efi_disk {
    datastore_id = "vms"
    type         = "4m"
  }

  disk {
    datastore_id = "vms"
    import_from  = proxmox_virtual_environment_download_file.ubuntu_noble_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 32
  }

  initialization {
    datastore_id = "vms"
    interface    = "scsi2"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  memory {
    dedicated = 6144
  }

  network_device {
    bridge = "vmbr0"
  }

}
