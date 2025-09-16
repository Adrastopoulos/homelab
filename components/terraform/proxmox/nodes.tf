locals {
  nodes = {
    daedalus = {
      ip_address = "192.168.1.140"
      threads      = 64
      memory_gb  = 128

      storage = { }
    }
  }
}
