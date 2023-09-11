provider "nifcloud" {
  region = var.region
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}

resource "nifcloud_instance" "test" {
  count = var.instances

  instance_id       = format("test%03d", count.index)
  availability_zone = var.zone
  image_id          = data.nifcloud_image.ubuntu.id
  key_name          = nifcloud_key_pair.test.key_name
  security_group    = nifcloud_security_group.test.group_name
  instance_type     = var.instance_type
  accounting_type   = var.instance_accounting_type

  network_interface {
    network_id = "net-COMMON_GLOBAL"
  }

  network_interface {
    network_id = "net-COMMON_PRIVATE"
  }
}

data "nifcloud_image" "ubuntu" {
  image_name = var.image_name
}

resource "nifcloud_key_pair" "test" {
  key_name   = "testkey"
  public_key = base64encode(tls_private_key.rsa.public_key_openssh)
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.rsa.private_key_openssh
  filename        = "${path.module}/${var.private_key_name}"
  file_permission = "0600"
}

resource "tls_private_key" "rsa" {
  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}

resource "nifcloud_security_group" "test" {
  group_name        = "testfw"
  availability_zone = var.zone

}

resource "nifcloud_security_group_rule" "test" {
  security_group_names = [nifcloud_security_group.test.group_name]
  type                 = "IN"
  from_port            = 0
  to_port              = 65535
  protocol             = "TCP"
  cidr_ip              = "0.0.0.0/0"
}

resource "local_file" "ansible_inventory" {
  content         = <<EOT
[all]
${join("\n", nifcloud_instance.test[*].public_ip)}
EOT
  filename        = "${path.module}/${var.ansible_inventory_name}"
  file_permission = "0644"
}
