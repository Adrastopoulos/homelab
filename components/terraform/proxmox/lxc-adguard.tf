resource "proxmox_lxc" "adguard" {
  target_node  = "daedalus"
  hostname     = "adguard"
  ostemplate   = "zfs-templates:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
  password     = var.container_password
  unprivileged = true
  start        = true
  onboot       = true

  cores  = 2
  memory = 1024
  swap   = 512

  rootfs {
    storage = "hermes"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.53/24"
    gw     = "192.168.1.1"
  }

  features {
    nesting = true
  }

  startup = "order=1,up=30"

  tags = "dns,adguard,docker,infrastructure"

  lifecycle {
    ignore_changes = [
      network[0].hwaddr,
      ssh_public_keys,
    ]
  }

  ssh_public_keys = file("~/.ssh/id_ed25519.pub")
}
