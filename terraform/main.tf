locals {
  defaults = {
    template          = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    bridge            = "vmbr0"
    gateway           = "192.168.1.1"
    swap              = 512
    unprivileged      = true
    start_on_boot     = true
    cores             = 2
    memory            = 512
    disk_size         = 8
    ssh_key           = var.ssh_public_key_path
    password          = var.default_password
    os_type           = "debian"
    domain            = ""
    port              = null
    ssl               = false
    letsencrypt_email = ""
    certificate_id    = 0
  }

  service_files = fileset("${path.module}/../services", "*/service.yml")

  services = {
    for f in local.service_files :
    dirname(f) => merge(
      local.defaults,
      { hostname = dirname(f), name = dirname(f), ssh_key = pathexpand(var.ssh_public_key_path) },
      yamldecode(file("${path.module}/../services/${f}"))
    )
  }
  service_list = [
    for name, svc in local.services :
    {
      name              = name
      host              = split("/", svc.ip_address)[0]
      domain            = svc.domain
      port              = svc.port
      ssl               = svc.ssl
      letsencrypt_email = svc.letsencrypt_email
      certificate_id    = svc.certificate_id
    }
    if svc.domain != ""
  ]
}

module "containers" {
  source   = "../modules/lxc-container"
  for_each = local.services

  service      = each.value
  node_name    = var.node_name
  datastore_id = var.datastore_id
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/templates/inventory.yml.tpl", {
    services        = local.services
    ssh_private_key = pathexpand(trimsuffix(var.ssh_public_key_path, ".pub"))
  })
  filename = "${path.module}/../ansible/inventory.yml"
}

resource "local_file" "services_list" {
  content  = templatefile("${path.module}/templates/services.yml.tpl", { service_list = local.service_list })
  filename = "${path.module}/../ansible/group_vars/all/services.yml"
}
