
resource "libvirt_volume" "centos8vanilla-qcow2" {
  name = "centos8vanilla-qcow2"
  pool = libvirt_pool.centos.name
  source = var.centos_8_img_url
  format = "qcow2"
}

resource "libvirt_domain" "domain-vanilla" {
  name   = var.vm_hostname_vanilla
  memory = "8192"
  vcpu   = 8

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
    hostname       = var.vm_hostname_vanilla
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
    volume_id = libvirt_volume.centos8vanilla-qcow2.id
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
