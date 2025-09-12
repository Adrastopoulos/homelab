resource "proxmox_lxc" "containers" {
  for_each = var.lxc_containers

  target_node     = each.value.node
  hostname        = each.key
  ostemplate      = each.value.ostemplate
  password        = each.value.password
  ssh_public_keys = each.value.ssh_public_keys
  unprivileged    = each.value.unprivileged

  cores  = each.value.cores
  memory = each.value.memory
  swap   = each.value.swap

  rootfs {
    storage = each.value.storage
    size    = each.value.disk
  }

  network {
    name     = each.value.network.name
    bridge   = each.value.network.bridge
    ip       = each.value.network.ip
    ip6      = each.value.network.ip6
    gw       = each.value.network.gw
    gw6      = each.value.network.gw6
    hwaddr   = each.value.network.hwaddr
    mtu      = each.value.network.mtu
    rate     = each.value.network.rate
    tag      = each.value.network.tag
    trunks   = each.value.network.trunks
    firewall = each.value.network.firewall
  }

  dynamic "features" {
    for_each = (
      each.value.features.fuse != null ||
      each.value.features.keyctl != null ||
      each.value.features.mount != null ||
      each.value.features.nesting != null ||
      each.value.features.force_unprivileged != null
    ) ? [1] : []
    content {
      fuse               = each.value.features.fuse
      keyctl             = each.value.features.keyctl
      mount              = each.value.features.mount
      nesting            = each.value.features.nesting
      force_unprivileged = each.value.features.force_unprivileged
    }
  }

  dynamic "mountpoint" {
    for_each = { for mp in each.value.mountpoint : mp.key => mp }
    content {
      key     = mountpoint.value.key
      slot    = mountpoint.value.slot
      storage = mountpoint.value.storage
      mp      = mountpoint.value.mp
      size    = mountpoint.value.size
    }
  }

  tags        = each.value.tags
  start       = each.value.start
  onboot      = each.value.onboot
  description = each.value.description

  lifecycle {
    ignore_changes = [
      network[0].hwaddr,
    ]
  }
}