variable "libvirt_disk_path" {
  description = "path for libvirt pool"
  default     = "/opt/kvm/pool1"
}

variable "centos_8_img_url" {
  description = "centos 8 image"
  default     = "/home/jho/iso/CentOS-8-GenericCloud-8.4.2105-20210603.0.x86_64.qcow2"
}

variable "vm_hostname_scl" {
  description = "vm hostname"
  default     = "centos8scl"
}

variable "vm_hostname" {
  description = "vm hostname"
  default     = "terraform-kvm-centos"
}

variable "ssh_username" {
  description = "the ssh user to use"
  default     = "cloud-user"
}

variable "ssh_private_key" {
  description = "the private key to use"
  default     = "~/.ssh/id_rsa"
}
