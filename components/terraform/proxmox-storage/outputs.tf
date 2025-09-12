output "storage_pools" {
  description = "Created storage pools"
  value = {
    for k, v in proxmox_storage.pools : k => {
      id      = v.storage_id
      type    = v.type
      pool    = v.pool
      path    = v.path
      content = v.content
      nodes   = v.nodes
    }
  }
}