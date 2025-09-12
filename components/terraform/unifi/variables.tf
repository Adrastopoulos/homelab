variable "unifi_username" {
  description = "UniFi controller username"
  type        = string
  default     = "admin"
}

variable "unifi_password" {
  description = "UniFi controller password"
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
  default     = "guest-password-123"
  sensitive   = true
}

variable "iot_wifi_password" {
  description = "IoT WiFi network password"
  type        = string
  default     = "iot-password-123"
  sensitive   = true
}
