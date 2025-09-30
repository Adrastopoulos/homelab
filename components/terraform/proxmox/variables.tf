variable "proxmox_api_host" {
  type = string
  default = "192.168.1.138:8006"
}

variable "proxmox_api_token_id" {
  type        = string
  default     = "terraform@pve!provider"
}

variable "proxmox_api_token_secret" {
  type        = string
  sensitive   = true
}

variable "container_password" {
  type = string
  sensitive = true
}
