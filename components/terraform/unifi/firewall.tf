resource "unifi_firewall_rule" "block_iot_internet" {
  name        = "Block IoT Internet Access"
  ruleset     = "LAN_OUT"
  action      = "drop"
  rule_index  = 20010
  protocol    = "all"
  src_address = "192.168.20.0/24"
  dst_address = "0.0.0.0/0"
  enabled     = true
}

resource "unifi_firewall_rule" "block_iot_to_homelab" {
  name        = "Block IoT to Homelab"
  ruleset     = "LAN_IN"
  action      = "drop"
  rule_index  = 20020
  protocol    = "all"
  src_address = "192.168.20.0/24"
  dst_address = "192.168.10.0/24"
  enabled     = true
}
