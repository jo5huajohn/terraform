variable "node_name" {
  description = "Name of the Proxmox node to provision the ingress container."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the container."
  type        = list(string)
  default     = []
}

variable "cores" {
  description = "Number of CPU cores."
  type        = number
  default     = 1
}

variable "memory" {
  description = "Amount of dedicated memory in MiB."
  type        = number
  default     = 1024
}

variable "disk_storage" {
  description = "Storage location for the container disk."
  type        = string
  default     = "local-lvm"
}

variable "disk_size" {
  description = "Storage size of the container disk in GiB."
  type        = number
  default     = 20
}

variable "hostname" {
  description = "Hostname of the container."
  type        = string
}

variable "network_interface" {
  description = "Name of the network interface of the container."
  type        = string
}

variable "os_template_id" {
  description = "The path to the container OS template file."
  type        = string
}

variable "os_type" {
  description = "The distribution of the container template."
  type        = string
}

variable "user_ssh_key_public" {
  description = "Public SSH Key for container default user."
  default     = null
  type        = string
  sensitive   = true
  validation {
    condition     = can(regex("(?i)PRIVATE", var.user_ssh_key_public)) == false
    error_message = "Error: Private SSH Key."
  }
}

variable "user_password" {
  description = "Password for container default user."
  type        = string
  sensitive   = true
  default     = null
}
