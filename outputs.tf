output "Admin account name" {
  value = "${module.single_instance.admin_user}"
}

output "Admin account password" {
  value = "${module.single_instance.admin_password}"
}

output "Public IP" {
  value = "${module.single_instance.public_ip}"
}

output "Public IP FQDN" {
  value = "${module.single_instance.public_ip_fqdn}"
}
