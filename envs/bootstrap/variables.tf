variable "acme_dns_cf_account_id" {
    description = "Cloudflare Account ID for ACME DNS plugin"
    type        = string
    sensitive   = true
}

variable "acme_dns_cf_email" {
    description = "Email for ACME DNS plugin"
    type        = string
    sensitive   = true
}

variable "acme_dns_cf_token" {
    description = "Cloudflare API token for ACME DNS plugin"
    type        = string
    sensitive   = true
}

variable "acme_dns_cf_zone_id" {
    description = "Cloudflare Zone ID for ACME DNS plugin"
    type        = string
    sensitive   = true
}

variable "time_zone" {
    description = "Current timezone"
    type        = string
    sensitive   = true
}

variable "virtual_environment_address"  {
    description = "Address of the node"
    type        = string
    sensitive   = true
}

variable "virtual_environment_api_token" {
    type        = string
    sensitive   = true
}

variable "virtual_environment_vm_username" {
    type        = string
    sensitive   = true
}

variable "ssh_public_key_path" {
    description = "Path to SSH public key"
    type        = string
    sensitive   = true
}

variable "ansible_public_key_path" {
    description = "Path to the SSH public key for the Ansible user"
    type        = string
    sensitive   = true
}
