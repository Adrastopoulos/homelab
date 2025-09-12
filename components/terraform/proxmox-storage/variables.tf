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

variable "storage_pools" {
  description = "Storage pools to create"
  type = map(object({
    type        = string
    pool        = optional(string)
    path        = optional(string)
    content     = list(string)
    nodes       = list(string)
    sparse      = optional(bool, true)
    export      = optional(bool, true)
    disable     = optional(bool, false)
    maxfiles    = optional(number)
    shared      = optional(bool, false)
  }))
  default = {}
}