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

variable "proxmox_nodes" {
  description = "Proxmox nodes configuration"
  type = map(object({
    address     = string
    description = optional(string, "")
    tags        = optional(list(string), [])
  }))
  default = {}
}