output "ssh_commands" {
  value = {
    for k, v in nifcloud_instance.test : v.id => format("ssh -i %s root@%s", "${path.module}/${var.private_key_name}", v.public_ip)
  }
}

output "instance_ips" {
  value = {
    for k, v in nifcloud_instance.test : v.id => v.public_ip
  }
}
