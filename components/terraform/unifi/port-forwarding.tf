resource "unifi_port_forward" "plex" {
  name     = "Plex Media Server"
  dst_port = "32400"
  fwd_ip   = "192.168.10.100"
  fwd_port = "32400"
  protocol = "tcp"
}

resource "unifi_port_forward" "ssh" {
  name     = "SSH to Docker Host"
  dst_port = "2222"
  fwd_ip   = "192.168.10.100"
  fwd_port = "22"
  protocol = "tcp"
}
