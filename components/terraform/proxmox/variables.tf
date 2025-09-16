variable "proxmox_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
  default     = "root@pam!terraform"
}

variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "container_password" {
  description = "Docker container password"
  type = string
  sensitive = true
}
