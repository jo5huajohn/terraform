variable "acme_dns_cf_account_id" {
    type        = string
    description = "Cloudflare Account ID for ACME DNS plugin"
}

variable "acme_dns_cf_email" {
    type        = string
    description = "Email for ACME DNS plugin"
}

variable "acme_dns_cf_token" {
    type        = string
    description = "Cloudflare API token for ACME DNS plugin"
}

variable "acme_dns_cf_zone_id" {
    type        = string
    description = "Cloudflare Zone ID for ACME DNS plugin"
}

variable "virtual_environment_address"  {
    type        = string
    description = "Address of the node"
}

variable "virtual_environment_api_token" {
}

variable "virtual_environment_vm_username" {
}

variable "virtual_environment_user_account_password" {
    type        = string
    description = "Password of user in virtual environment"    
}

variable "ssh_pub_key" {
    type        = string
    description = "SSH public key for users"
}

variable "ssh_public_key" {
    type        = string
    description = "(Deprecated) Use 'ssh_pub_key' instead"
}
