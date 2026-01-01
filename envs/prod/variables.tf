variable "virtual_environment_ip"  {
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