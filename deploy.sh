#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ ! -f .env ]]; then
  echo "ERROR: .env not found. Copy .env.example to .env and fill it in." >&2
  exit 1
fi
set -a
source .env
set +a

echo "==> [1/2] Terraform (init + validate + apply)"
(
  cd terraform
  terraform init
  terraform fmt -recursive
  terraform validate
  terraform apply -auto-approve
)

echo "==> [2/2] Ansible (playbook)"
(
  cd ansible
  ansible-playbook playbooks/site.yml
)

echo "==> FINISHED"
