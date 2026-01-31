variable "node_name" {
  description = "Name of the Proxmox node to provision the ingress container."
  type        = string
}

variable "name" {
  description = "Name of the virtual machine."
  type        = string
}

variable "on_boot" {
  description = "Start on boot."
  type        = bool
  default     = true
}

variable "stop_on_destroy" {
  description = "Stop virtual machine on destroy."
  type        = bool
  default     = true
}

variable "cpu_type" {
  description = "Architecture of the CPU"
  type        = string
  default     = "x86-64-v2-AES"
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

variable "image_id" {
  description = "Disk image path."
  type        = "string"
}

variable "disk_interface" {
  description = "Disk interface."
  type        = string
}

variable "iothread" {
  description = "Iothread"
  type        = bool
  default     = true
}

variable "hostname" {
  description = "Hostname of the container."
  type        = string
}

variable "network_interface" {
  description = "Name of the network interface of the container."
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

variable "discard" {
  description = "Whether to pass discard/trim requests to the underlying storage."
  type        = bool
}

variable "disk_size" {
  description = "The disk size in gigabytes."
  type        = string
}

variable "ssd" {
  description = "Whether to use ssd for this disk drive."
  type        = bool
}
