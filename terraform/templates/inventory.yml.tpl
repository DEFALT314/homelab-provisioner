all:
  children:
    docker_hosts:
      hosts:
%{ for name, h in hosts ~}
        ${name}:
          ansible_host: ${split("/", h.ip_address)[0]}
          service_names: ${jsonencode(host_services[name])}
%{ endfor ~}
      vars:
        ansible_user: root
        ansible_ssh_private_key_file: ${ssh_private_key}
