resource "proxmox_vm_qemu" "vms" {
  for_each = var.vms

  name         = each.key
  target_node  = each.value.node
  iso          = each.value.iso
  clone        = each.value.clone
  full_clone   = each.value.clone != null ? true : null
  
  cores    = each.value.cores
  sockets  = each.value.sockets
  cpu      = each.value.cpu
  memory   = each.value.memory
  balloon  = each.value.balloon
  
  boot     = each.value.boot
  bootdisk = each.value.bootdisk
  scsihw   = each.value.scsihw
  hotplug  = each.value.hotplug
  agent    = each.value.agent
  os_type  = each.value.qemu_os
  bios     = each.value.bios
  machine  = each.value.machine

  dynamic "disk" {
    for_each = each.value.disk
    content {
      storage    = disk.value.storage
      type       = disk.value.type
      size       = disk.value.size
      format     = disk.value.format
      cache      = disk.value.cache
      backup     = disk.value.backup
      iothread   = disk.value.iothread
      replicate  = disk.value.replicate
      ssd        = disk.value.ssd
      discard    = disk.value.discard
    }
  }

  dynamic "network" {
    for_each = each.value.network
    content {
      bridge    = network.value.bridge
      model     = network.value.model
      macaddr   = network.value.macaddr
      queues    = network.value.queues
      rate      = network.value.rate
      firewall  = network.value.firewall
      link_down = network.value.link_down
      mtu       = network.value.mtu
      tag       = network.value.tag
    }
  }

  dynamic "serial" {
    for_each = { for s in each.value.serial : s.id => s }
    content {
      id   = serial.value.id
      type = serial.value.type
    }
  }

  dynamic "usb" {
    for_each = { for idx, u in each.value.usb : idx => u }
    content {
      host = usb.value.host
      usb3 = usb.value.usb3
    }
  }

  dynamic "vga" {
    for_each = each.value.vga != null ? [each.value.vga] : []
    content {
      type   = vga.value.type
      memory = vga.value.memory
    }
  }

  tags        = each.value.tags
  onboot      = each.value.onboot
  startup     = each.value.startup
  description = each.value.description
  protection  = each.value.protection
  tablet      = each.value.tablet
  kvm         = each.value.kvm
  numa        = each.value.numa
  
  # Cloud-init
  ciuser       = each.value.ciuser
  cipassword   = each.value.cipassword
  cicustom     = each.value.cicustom
  searchdomain = each.value.searchdomain
  nameserver   = each.value.nameserver
  sshkeys      = each.value.sshkeys
  ipconfig0    = each.value.ipconfig0
  ipconfig1    = each.value.ipconfig1
  ipconfig2    = each.value.ipconfig2

  lifecycle {
    ignore_changes = [
      network[0].macaddr,
    ]
  }
}