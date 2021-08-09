
provider "libvirt" {
  uri = "qemu:///system"

}

resource "libvirt_pool" "centos" {
  name = "centos"
  type = "dir"
  path = var.libvirt_disk_path
}

resource "libvirt_volume" "centos-qcow2" {
  name = "centos-qcow2"
  pool = libvirt_pool.centos.name
  source = var.centos_8_img_url
  format = "qcow2"
}

data "template_file" "user_data" {
  template = file("${path.module}/config/cloud_init.yml")
}

data "template_file" "network_config" {
  template = file("${path.module}/config/network_config.yml")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.centos.name
}

resource "libvirt_domain" "domain-centos" {
  name   = var.vm_hostname
  memory = "8192"
  vcpu   = 8

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
    hostname       = var.vm_hostname
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.centos-qcow2.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'"
    ]

    connection {
      type                = "ssh"
      user                = var.ssh_username
      host                = libvirt_domain.domain-centos.network_interface[0].addresses[0]
      private_key         = file(var.ssh_private_key)
      timeout             = "2m"
    }
  }

  provisioner "local-exec" {
    command = <<EOT
      sudo systemctl enable --now cockpit.socket 
      EOT
  }
}
