resource "proxmox_vm_qemu" "docker_vm" {
  name        = "docker-vm"
  target_node = "daedalus"
  vmid        = 200
  description        = "Docker host VM running Ubuntu Server"

  clone = "ubuntu-22.04-template"

  cpu {
    cores = 8
  }
  memory  = 16384
  scsihw  = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot    = "scsi0"
    size    = "100G"
    type    = "disk"
    storage = "local-lvm"
    iothread = true
  }

  disk {
    slot    = "scsi1"
    size    = "200G"
    type    = "disk"
    storage = "docker-data"
    iothread = true
  }

  network {
    id = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  onboot = true

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
