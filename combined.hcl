variable "name" {
  type    = string
  default = "mynewimage-win-2019-with-security-suite"
}

variable "zone" {
  type    = string
  default = "us-west2-b"
}

variable "vpc_network" {
  type    = string
  default = "shared-prod-vpc"
}

variable "subnetwork" {
  type    = string
  default = "private-us-west2--prod-subnet"
}

variable "project" {
  type    = string
  default = "image-repo-it-systems"
}

variable "source_image_family" {
  type    = string
  default = "windows-2019"
}

variable "machine-type" {
  type    = string
  default = "n1-standard-4"
}

variable "packer_username" {
  type    = string
  default = "packer"
}

variable "packer_user_password" {
  type    = string
  default = "I am a very secure Pas!"
}

variable "disk_size" {
  type    = number
  default = 100
}

variable "ssh_timeout" {
  type    = string
  default = "1h"
}

variable "image_name" {
  type    = string
  default = "myimage-base-server-2019-with-security-suite"
}

variable "image_description" {
  type    = string
  default = "Windows 2019 Server Built with Packer"
}

variable "communicator" {
  type    = string
  default = "ssh"
}

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

source "googlecompute" "windows-2019-google-cloud" {
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
    server_type = "windows-2019"
  }
  metadata = {
    windows-startup-script-cmd = "net user ${var.packer_username} \"${var.packer_user_password}\" /add /y & wmic UserAccount where Name=\"${var.packer_username}\" set PasswordExpires=False & net localgroup administrators ${var.packer_username} /add & powershell Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 & powershell Start-Service sshd & powershell Set-Service -Name sshd -StartupType 'Automatic' & powershell New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22 & powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \"Set-ExecutionPolicy -ExecutionPolicy bypass -Force\""
  }
}

build {
  name    = "windows-2019-google-cloud"
  sources = ["sources.googlecompute.windows-2019-google-cloud"]

  provisioner "file" {
    source      = "./Software_tools/installers/Windows"
    destination = "C:\\installers\\"
  }

  provisioner "powershell" {
    elevated_user     = "SYSTEM" # try using SYSTEM
    elevated_password = ""       # Try ""
    #remote_env_var_path = "C:/installers/"
    execute_command = "powershell -executionpolicy bypass"
    script          = "./Software_tools/installers/Windows/uac_off.ps1" # double .. rolls up one folder
  }

  provisioner "windows-restart" {} # reboot for UAC change

}
