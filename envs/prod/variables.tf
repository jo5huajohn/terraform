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

variable "virtual_environment_user_account_password" {
    description = "Password of user in virtual environment"    
    type        = string
    sensitive   = true
}

variable "ssh_pub_key" {
    description = "SSH public key for users"
    type        = string
    sensitive   = true
}

variable "ssh_public_key" {
    description = "(Deprecated) Use 'ssh_pub_key' instead"
    type        = string
    sensitive   = true
}
