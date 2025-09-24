# Ansible

This repository contains over 50 roles and 30 playbooks to manage my homelab infrastructure.

## Ansible installation

Install Ansible:

```bash
pipx install --include-deps ansible ansible-lint
```

Update Ansible:

```bash
pipx upgrade --include-injected ansible ansible-lint
```

Install extra Python dependencies:

```bash
pipx inject ansible requests netaddr
```

Install Ansible roles:

```bash
ansible-galaxy install -r requirements.yml
```

Update Ansible roles:

```bash
ansible-galaxy install -r requirements.yml  --force
```

## Ansible setup

All host and group variables are encrypted with Ansible vault, password file is `.vault`.

## Playbook Organization

Playbooks are organized into categories:

- `playbooks/system/` - Infrastructure and system management (Proxmox hosts, networking, etc.)
- `playbooks/applications/` - Application deployments (Immich, Jellyfin, Grafana, etc.)

## Proxmox Host Setup

Bootstrap new Proxmox hosts:

```bash
# On the Proxmox host
./bootstrap-proxmox.sh

# Add SSH key
ssh-copy-id root@proxmox-host-ip

# Run bootstrap playbook
ansible-playbook playbooks/system/proxmox-bootstrap.yaml

# Run ongoing management
ansible-playbook playbooks/system/proxmox-hosts.yaml
```

## Ansible commands

Show inventory:

```bash
ansible-inventory --graph
```

Run system management playbooks:

```bash
ansible-playbook playbooks/system/proxmox-hosts.yaml
```

Run application playbooks:

```bash
ansible-playbook playbooks/applications/immich.yaml
ansible-playbook -e docker_pull=always playbooks/applications/[playbook]
```

Update LXC containers:

```bash
ansible-playbook playbooks/lxc_upgrade.yml
```

Prune Docker dangling images:

```bash
ansible-playbook playbooks/lxc_docker_prune.yml
```

Execute remote command:

```bash
ansible [pattern] -a [command]
```

Lint Ansible playbooks:

```bash
ansible-lint
```
