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
  default = "Ubuntu 22.04 Docker host template"
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
  default = 4
}

variable "memory" {
  type    = number
  default = 8192
}

variable "disk_size" {
  type    = string
  default = "64G"
}

source "proxmox-iso" "ubuntu" {
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
    "<esc><wait>",
    "<enter><wait>",
    "/casper/vmlinuz autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "initrd=/casper/initrd ---\n"
  ]

  http_directory = "http"

  ssh_username = "ubuntu"
  ssh_timeout  = "20m"
}

build {
  name    = "ubuntu-jammy-docker-template"
  sources = ["source.proxmox-iso.ubuntu"]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "sudo rm /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo cloud-init clean",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo rm -f /etc/netplan/00-installer-config.yaml",
      "sudo sync"
    ]
  }

  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }

  provisioner "shell" {
    inline = [
      "sudo mkdir -p /etc/cloud/cloud.cfg.d",
      "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ca-certificates curl gnupg lsb-release",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "printf 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\n' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io"
    ]
  }
}
