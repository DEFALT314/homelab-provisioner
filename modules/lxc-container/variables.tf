variable "service" {
  description = "Service configuration object containing all parameters for the container"
  type = object({
    vm_id         = optional(number)
    hostname      = string
    ip_address    = string
    gateway       = string
    cores         = number
    memory        = number
    swap          = number
    disk_size     = number
    template      = string
    bridge        = string
    unprivileged  = bool
    start_on_boot = bool
    ssh_key       = string
    password      = string
    os_type       = string
    domain        = string
    port          = number
  })
}

variable "node_name" {
  description = "Proxmox node name where the container will be created"
  type        = string
}

variable "datastore_id" {
  description = "Datastore ID for the container disk"
  type        = string
}