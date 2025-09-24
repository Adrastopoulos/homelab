#!/bin/bash

set -e

echo "Bootstrapping Proxmox host for Ansible management"

apt update
apt install -y openssh-server python3

systemctl enable ssh
systemctl start ssh

mkdir -p /root/.ssh
chmod 700 /root/.ssh

HOST_IP=$(hostname -I | awk '{print $1}')

echo "Bootstrap complete - host ready for Ansible management"
echo "Do these from your LOCAL machine:"
echo "1. Add SSH key: ssh-copy-id root@${HOST_IP}"
echo "2. Run bootstrap playbook: ansible-playbook playbooks/system/proxmox-bootstrap.yaml"
