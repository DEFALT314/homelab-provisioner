output "ip" {
  description = "IP address of the created container"
  value       = split("/", proxmox_virtual_environment_container.this.initialization[0].ip_config[0].ipv4[0].address)[0]
}

output "vm_id" {
  description = "VM ID of the created container"
  value       = proxmox_virtual_environment_container.this.vm_id
}

output "hostname" {
  description = "Hostname of the created container"
  value       = proxmox_virtual_environment_container.this.initialization[0].hostname
}