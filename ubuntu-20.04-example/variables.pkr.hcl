variable "name" {
  type    = string
  default = "mynewimage-ubuntu-2004-with-nettools"
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
  default = "images-vpc-subnet1"
}

variable "project" {
  type    = string
  default = "images-repo-394020"
}

variable "source_image_family" {
  type    = string
  default = "ubuntu-pro-2004-lts"
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
  default = "mynewimage-ubuntu-2004-with-nettools"
}

variable "image_description" {
  type    = string
  default = "Ubuntu 20.04 Server Built with Packer"
}

variable "communicator" {
  type    = string
  default = "ssh"
}