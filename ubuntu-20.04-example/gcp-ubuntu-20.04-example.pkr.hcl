packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

locals {
  hostname = "${var.name}"
}

source "googlecompute" "ubuntu-2004-google-cloud" {
  instance_name       = local.hostname
  image_name          = "${var.image_name}-${formatdate("MMDDYYYY", timestamp())}"
  image_description   = "${var.image_description}-${formatdate("MMDDYYYY", timestamp())}"
  project_id          = var.project
  source_image_family = var.source_image_family
  machine_type        = var.machine-type
  subnetwork          = var.subnetwork
  network             = var.vpc_network
  zone                = var.zone
  communicator        = var.communicator
  omit_external_ip    = true
  use_internal_ip     = true
  ssh_username        = var.packer_username
  ssh_password        = var.packer_user_password
  ssh_timeout         = var.ssh_timeout
  disk_size           = var.disk_size
  tags                = ["ssh-server"]

  image_labels = {
    server_type = "ubuntu-2004"
  }
  metadata = {
      }
}

build {
  name    = "ubuntu-pro-2004-lts"
  sources = ["sources.googlecompute.ubuntu-2004-google-cloud"]

# Copies files from the REPO to the local drive on the ubuntu Machine.
  provisioner "file" {
    source      = "../Software_tools/installers/Linux"
    destination = "\\tmp\\installers"
  }

  # Provisioner to update and install packages on Ubuntu.
  provisioner "shell" {
    script = "./gcp-ubuntu-20.04-example.sh"
  }
}

