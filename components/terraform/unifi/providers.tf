provider "unifi" {
  username       = var.unifi_username
  password       = var.unifi_password
  api_url        = "https://192.168.1.1"
  allow_insecure = true
  site           = "default"
}
