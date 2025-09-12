data "unifi_ap_group" "default" {
}

resource "unifi_wlan" "homelab" {
  name          = "mochanet"
  network_id    = unifi_network.homelab.id
  security      = "wpapsk"
  passphrase    = var.wifi_password
  user_group_id = data.unifi_user_group.default.id
  ap_group_ids  = [data.unifi_ap_group.default.id]
}

resource "unifi_wlan" "guest" {
  name          = "mochanet-guest"
  network_id    = unifi_network.guest.id
  security      = "wpapsk"
  passphrase    = var.guest_wifi_password
  is_guest      = true
  user_group_id = unifi_user_group.guests.id
  ap_group_ids  = [data.unifi_ap_group.default.id]
}

resource "unifi_wlan" "iot" {
  name          = "mochanet-iot"
  network_id    = unifi_network.iot.id
  security      = "wpapsk"
  passphrase    = var.iot_wifi_password
  hide_ssid     = true
  user_group_id = data.unifi_user_group.default.id
  ap_group_ids  = [data.unifi_ap_group.default.id]
}
