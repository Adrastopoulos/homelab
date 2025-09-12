output "vms" {
  description = "Created VMs"
  value = {
    for k, v in proxmox_vm_qemu.vms : k => {
      vmid        = v.vmid
      name        = v.name
      node        = v.target_node
      cores       = v.cores
      memory      = v.memory
      status      = v.onboot ? "auto-start" : "manual"
      tags        = v.tags
      ipconfig0   = v.ipconfig0
    }
  }
}