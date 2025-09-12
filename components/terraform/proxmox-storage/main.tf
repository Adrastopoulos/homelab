resource "proxmox_storage" "pools" {
  for_each = var.storage_pools

  storage_id = each.key
  type       = each.value.type
  pool       = each.value.pool
  path       = each.value.path
  content    = each.value.content
  nodes      = each.value.nodes
  sparse     = each.value.sparse
  export     = each.value.export
  disable    = each.value.disable
  maxfiles   = each.value.maxfiles
  shared     = each.value.shared
}