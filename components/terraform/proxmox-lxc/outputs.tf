output "lxc_containers" {
  description = "Created LXC containers"
  value = {
    for k, v in proxmox_lxc.containers : k => {
      vmid      = v.vmid
      hostname  = v.hostname
      node      = v.target_node
      ip        = v.network[0].ip
      status    = v.start ? "running" : "stopped"
      tags      = v.tags
    }
  }
}