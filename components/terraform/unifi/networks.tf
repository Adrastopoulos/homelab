data "unifi_network" "default" {
  name = "Default"
}

resource "unifi_network" "iot" {
  name         = "iot"
  purpose      = "vlan-only"
  subnet       = "192.168.20.0/24"
  vlan_id      = 20
  dhcp_enabled = true
  dhcp_start   = "192.168.20.100"
  dhcp_stop    = "192.168.20.200"
  dhcp_dns     = ["1.1.1.1", "1.0.0.1"]
}

resource "unifi_network" "guest" {
  name         = "guest"
  purpose      = "corporate"
  subnet       = "192.168.30.0/24"
  vlan_id      = 30
  dhcp_enabled = true
  dhcp_start   = "192.168.30.100"
  dhcp_stop    = "192.168.30.200"
  dhcp_dns     = ["1.1.1.1", "1.0.0.1"]
}
