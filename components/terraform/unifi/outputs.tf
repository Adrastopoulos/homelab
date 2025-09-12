output "networks" {
  description = "Created networks"
  value = {
    homelab = {
      id         = unifi_network.homelab.id
      name       = unifi_network.homelab.name
      subnet     = unifi_network.homelab.subnet
      vlan_id    = unifi_network.homelab.vlan_id
    }
    iot = {
      id         = unifi_network.iot.id
      name       = unifi_network.iot.name
      subnet     = unifi_network.iot.subnet
      vlan_id    = unifi_network.iot.vlan_id
    }
    guest = {
      id         = unifi_network.guest.id
      name       = unifi_network.guest.name
      subnet     = unifi_network.guest.subnet
      vlan_id    = unifi_network.guest.vlan_id
    }
  }
}

output "wlan_networks" {
  description = "Created WLAN networks"
  value = {
    homelab = {
      id         = unifi_wlan.homelab.id
      name       = unifi_wlan.homelab.name
      network_id = unifi_wlan.homelab.network_id
    }
    guest = {
      id         = unifi_wlan.guest.id
      name       = unifi_wlan.guest.name
      network_id = unifi_wlan.guest.network_id
      is_guest   = unifi_wlan.guest.is_guest
    }
    iot = {
      id         = unifi_wlan.iot.id
      name       = unifi_wlan.iot.name
      network_id = unifi_wlan.iot.network_id
      hide_ssid  = unifi_wlan.iot.hide_ssid
    }
  }
  sensitive = true
}

output "firewall_rules" {
  description = "Created firewall rules"
  value = {
    block_iot_internet = {
      id         = unifi_firewall_rule.block_iot_internet.id
      name       = unifi_firewall_rule.block_iot_internet.name
      rule_index = unifi_firewall_rule.block_iot_internet.rule_index
    }
    block_iot_to_homelab = {
      id         = unifi_firewall_rule.block_iot_to_homelab.id
      name       = unifi_firewall_rule.block_iot_to_homelab.name
      rule_index = unifi_firewall_rule.block_iot_to_homelab.rule_index
    }
  }
}

output "port_forwards" {
  description = "Created port forwards"
  value = {
    plex = {
      id       = unifi_port_forward.plex.id
      name     = unifi_port_forward.plex.name
      dst_port = unifi_port_forward.plex.dst_port
      fwd_ip   = unifi_port_forward.plex.fwd_ip
    }
    ssh = {
      id       = unifi_port_forward.ssh.id
      name     = unifi_port_forward.ssh.name
      dst_port = unifi_port_forward.ssh.dst_port
      fwd_ip   = unifi_port_forward.ssh.fwd_ip
    }
  }
}