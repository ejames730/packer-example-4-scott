variable "name" {
  type    = string
  default = "mynewimage-win-2019-with-bginfo
}

variable "zone" {
  type    = string
  default = "us-west2-b"
}

variable "vpc_network" {
  type    = string
  default = "images-vpc"
}

variable "subnetwork" {
  type    = string
  default = "us-west2"
}

variable "project" {
  type    = string
  default = "image-repo"
}

variable "source_image_family" {
  type    = string
  default = "windows-2019"
}

variable "machine-type" {
  type    = string
  default = "n2-standard-4"
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
  default = "myimage-base-server-2019-with-bginfo"
}

variable "image_description" {
  type    = string
  default = "Windows 2019 Server Built with Packer"
}

variable "communicator" {
  type    = string
  default = "ssh"
}