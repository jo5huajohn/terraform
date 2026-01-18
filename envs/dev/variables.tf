variable "virtual_environment_address"  {
  description = "Address of the node"
  type        = string
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
