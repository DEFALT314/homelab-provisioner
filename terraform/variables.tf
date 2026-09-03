variable "proxmox_token" {
  type        = string
  description = "Proxmox API token for authentication"
  sensitive   = true
}

variable "default_password" {
  type        = string
  description = "Default password for the virtual machines"
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "Path to public SSH key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "datastore_id" {
  description = "Proxmox datastore ID"
  type        = string
  default     = "local-lvm"
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "proxmox"
}