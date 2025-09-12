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

variable "lxc_containers" {
  description = "LXC containers to create"
  type = map(object({
    node            = string
    ostemplate      = string
    password        = optional(string)
    ssh_public_keys = optional(string)
    cores           = optional(number, 1)
    memory          = optional(number, 512)
    swap            = optional(number, 512)
    disk            = optional(string, "8G")
    storage         = optional(string, "local-lvm")
    network = optional(object({
      name     = optional(string, "eth0")
      bridge   = optional(string, "vmbr0")
      ip       = optional(string, "dhcp")
      ip6      = optional(string)
      gw       = optional(string)
      gw6      = optional(string)
      hwaddr   = optional(string)
      mtu      = optional(number)
      rate     = optional(number)
      tag      = optional(number)
      trunks   = optional(string)
      firewall = optional(bool)
    }), {})
    features = optional(object({
      fuse      = optional(bool, false)
      keyctl    = optional(bool, false)
      mount     = optional(string)
      nesting   = optional(bool, false)
      force_unprivileged = optional(bool, false)
    }), {})
    mountpoint = optional(list(object({
      key     = string
      slot    = number
      storage = string
      mp      = string
      size    = string
    })), [])
    tags         = optional(string, "")
    start        = optional(bool, true)
    onboot       = optional(bool, false)
    unprivileged = optional(bool, true)
    description  = optional(string, "")
  }))
  default = {}
}