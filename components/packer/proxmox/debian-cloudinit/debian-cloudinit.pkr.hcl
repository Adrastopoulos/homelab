packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "template_name" {
  type        = string
  description = "Name of the Proxmox template to create"
}

variable "template_description" {
  type    = string
  default = "Debian cloud-init base image"
}

variable "proxmox_url" {
  type        = string
  description = "Proxmox API endpoint"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "Proxmox API token identifier"
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "Proxmox API token secret"
  sensitive   = true
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node to execute the build on"
}

variable "vmid" {
  type        = number
  description = "VMID to assign to the temporary build VM"
}

variable "iso_storage_pool" {
  type        = string
  description = "Storage where the ISO is stored"
}

variable "storage_pool" {
  type        = string
  description = "Storage pool to store the resulting template disk"
}

variable "iso_url" {
  type        = string
  description = "HTTP/HTTPS URL to the OS installer ISO"
}

variable "iso_checksum" {
  type        = string
  description = "Checksum for the installer ISO"
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 4096
}

variable "disk_size" {
  type    = string
  default = "16G"
}

source "proxmox-iso" "debian" {
  proxmox_url  = var.proxmox_url
  username     = var.proxmox_api_token_id
  token        = var.proxmox_api_token_secret
  insecure_skip_tls_verify = true

  node                 = var.proxmox_node
  vm_id                = var.vmid
  vm_name              = var.template_name
  template_description = var.template_description

  boot_iso {
    iso_url          = var.iso_url
    iso_checksum     = var.iso_checksum
    iso_storage_pool = var.iso_storage_pool
  }

  scsi_controller = "virtio-scsi-pci"
  disks {
    type         = "virtio"
    disk_size    = var.disk_size
    storage_pool = var.storage_pool
    format       = "qcow2"
  }

  cores  = var.cores
  memory = var.memory

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  qemu_agent              = true
  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  boot_wait    = "5s"
  boot_command = [
    "<esc><wait>",
    "auto ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "debian-installer=en_US auto locale=en_US kbd-chooser/method=us ",
    "netcfg/get_hostname=${var.template_name} netcfg/get_domain=local ",
    "fb=false debconf/frontend=noninteractive quiet ---<wait>"
  ]

  http_directory = "http"

  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout  = "20m"
}

build {
  name    = "debian-cloudinit-template"
  sources = ["source.proxmox-iso.debian"]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "rm -f /etc/ssh/ssh_host_*",
      "truncate -s 0 /etc/machine-id",
      "apt -y autoremove --purge",
      "apt -y clean",
      "apt -y autoclean",
      "cloud-init clean",
      "sync"
    ]
  }

  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }

  provisioner "shell" {
    inline = [
      "mkdir -p /etc/cloud/cloud.cfg.d",
      "cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"
    ]
  }
}
