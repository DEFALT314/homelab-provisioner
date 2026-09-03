resource "proxmox_virtual_environment_container" "this" {
  node_name = var.node_name
  vm_id     = var.service.vm_id

  initialization {
    hostname = var.service.hostname

    ip_config {
      ipv4 {
        address = var.service.ip_address
        gateway = var.service.gateway
      }
    }

    user_account {
      keys     = [trimspace(file(var.service.ssh_key))]
      password = var.service.password != "" ? var.service.password : null
    }
  }

  disk {
    datastore_id = var.datastore_id
    size         = var.service.disk_size
  }

  cpu {
    cores = var.service.cores
  }

  memory {
    dedicated = var.service.memory
    swap      = var.service.swap
  }

  features {
    nesting = true
  }

  network_interface {
    name   = "eth0"
    bridge = var.service.bridge
  }

  operating_system {
    template_file_id = var.service.template
    type             = var.service.os_type
  }

  unprivileged  = var.service.unprivileged
  start_on_boot = var.service.start_on_boot
}