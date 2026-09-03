---
services:
%{ for s in service_list ~}
  - name: "${s.name}"
    host: "${s.host}"
    domain: "${s.domain}"
    port: ${s.port}
    ssl: ${s.ssl}
    letsencrypt_email: "${s.letsencrypt_email}"
    certificate_id: ${s.certificate_id}
%{ endfor ~}