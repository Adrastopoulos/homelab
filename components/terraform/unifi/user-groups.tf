data "unifi_user_group" "default" {
  name = "Default"
}

resource "unifi_user_group" "guests" {
  name              = "guests"
  qos_rate_max_down = 50000  # 50 Mbps
  qos_rate_max_up   = 10000  # 10 Mbps
}