variable "unifi_api_url" {
  type = string
  default = "https://192.168.1.1"
}

variable "unifi_site" {
  type = string
  default = "default"
}

variable "unifi_username" {
  type        = string
  default     = "admin"
}

variable "unifi_password" {
  type        = string
  sensitive   = true
}

variable "wifi_password" {
  description = "Main WiFi network password"
  type        = string
  sensitive   = true
}

variable "guest_wifi_password" {
  description = "Guest WiFi network password"
  type        = string
  sensitive   = true
}

variable "iot_wifi_password" {
  description = "IoT WiFi network password"
  type        = string
  sensitive   = true
}
