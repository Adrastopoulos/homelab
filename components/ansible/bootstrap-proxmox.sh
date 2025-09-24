#!/bin/bash

set -e

echo "Bootstrapping Proxmox host for Ansible management"

apt update
apt install -y openssh-server python3

systemctl enable ssh
systemctl start ssh

mkdir -p /root/.ssh
chmod 700 /root/.ssh

echo "Bootstrap complete - host ready for Ansible management"
echo "Next steps:"
echo "1. Add SSH key: ssh-copy-id root@this-host"
echo "2. Run bootstrap playbook: ansible-playbook playbooks/system/proxmox-bootstrap.yaml"
