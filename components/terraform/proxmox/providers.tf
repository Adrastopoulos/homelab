provider "proxmox" {
  pm_api_url          = "https://${local.nodes.daedalus.ip_address}:8006/api2/json"

  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  pm_tls_insecure     = true
}
