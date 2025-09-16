resource "proxmox_lxc" "docker_host" {
  target_node  = "daedalus"
  hostname     = "docker-host"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password     = var.container_password
  unprivileged = true

  cores  = 4
  memory = 4096
  swap   = 2048

  rootfs {
    storage = "docker-data"
    size    = "50G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.10.100/24"
    gw     = "192.168.10.1"
  }

  features {
    nesting = true
    mount   = "nfs;cifs"
  }

  tags   = "docker,homelab"
  start  = true
  onboot = true

  lifecycle {
    ignore_changes = [
      network[0].hwaddr,
    ]
  }
}

resource "proxmox_lxc" "services_host" {
  target_node  = "icarus"
  hostname     = "services-host"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password     = var.container_password
  unprivileged = true

  cores  = 2
  memory = 2048
  swap   = 1024

  rootfs {
    storage = "vm-storage"
    size    = "30G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.10.101/24"
    gw     = "192.168.10.1"
  }

  tags   = "services,homelab"
  start  = true
  onboot = true

  lifecycle {
    ignore_changes = [
      network[0].hwaddr,
    ]
  }
}
