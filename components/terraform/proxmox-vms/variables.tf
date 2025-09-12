variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "vms" {
  description = "VMs to create"
  type = map(object({
    node           = string
    iso            = optional(string)
    clone          = optional(string)
    template       = optional(string)
    cores          = optional(number, 2)
    sockets        = optional(number, 1)
    cpu            = optional(string, "host")
    memory         = optional(number, 2048)
    balloon        = optional(number)
    boot           = optional(string, "c")
    bootdisk       = optional(string)
    scsihw         = optional(string, "virtio-scsi-pci")
    hotplug        = optional(string, "network,disk,usb")
    agent          = optional(number, 1)
    qemu_os        = optional(string, "l26")
    bios           = optional(string, "seabios")
    machine        = optional(string)
    
    disk = optional(list(object({
      storage    = string
      type       = optional(string, "scsi")
      size       = string
      format     = optional(string)
      cache      = optional(string)
      backup     = optional(bool, true)
      iothread   = optional(bool, false)
      replicate  = optional(bool, false)
      ssd        = optional(bool, false)
      discard    = optional(string)
    })), [])
    
    network = optional(list(object({
      bridge    = optional(string, "vmbr0")
      model     = optional(string, "virtio")
      macaddr   = optional(string)
      queues    = optional(number)
      rate      = optional(number)
      firewall  = optional(bool, false)
      link_down = optional(bool, false)
      mtu       = optional(number)
      tag       = optional(number)
    })), [])
    
    serial = optional(list(object({
      id   = number
      type = string
    })), [])
    
    usb = optional(list(object({
      host = string
      usb3 = optional(bool, false)
    })), [])
    
    vga = optional(object({
      type   = optional(string, "std")
      memory = optional(number)
    }))
    
    tags        = optional(string, "")
    start       = optional(bool, false)
    onboot      = optional(bool, false)
    startup     = optional(string)
    description = optional(string, "")
    protection  = optional(bool, false)
    tablet      = optional(bool, true)
    kvm         = optional(bool, true)
    numa        = optional(bool, false)
    
    # Cloud-init options
    ciuser     = optional(string)
    cipassword = optional(string)
    cicustom   = optional(string)
    searchdomain = optional(string)
    nameserver   = optional(string)
    sshkeys      = optional(string)
    ipconfig0    = optional(string)
    ipconfig1    = optional(string)
    ipconfig2    = optional(string)
  }))
  default = {}
}