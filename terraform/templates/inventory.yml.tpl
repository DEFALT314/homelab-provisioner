all:
  children:
    docker_hosts:
      hosts:
%{ for name, s in services ~}
        ${name}:
          ansible_host: ${split("/", s.ip_address)[0]}
          service_name: ${name}
%{ endfor ~}
      vars:
        ansible_user: root
        ansible_ssh_private_key_file: ${ssh_private_key}