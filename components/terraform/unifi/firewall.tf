resource "unifi_firewall_rule" "block_iot_internet" {
  name        = "Block IoT Internet Access"
  ruleset     = "LAN_OUT"
  action      = "drop"
  rule_index  = 20010
  protocol    = "all"
  src_network_id = unifi_network.iot.vlan_id
  dst_address = "0.0.0.0/0"
  enabled     = true
}
