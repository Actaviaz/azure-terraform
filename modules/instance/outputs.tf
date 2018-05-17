output "public_ip" {
  value = "${azurerm_public_ip.single_instance_pub_ip.ip_address}"
}

output "public_ip_fqdn" {
  value = "${azurerm_public_ip.single_instance_pub_ip.fqdn}"
}

output "admin_user" {
  value = "${var.instance_admin_user}"
}

output "usage" {
  value = "ssh -i <private_key> ${var.instance_admin_user}@${azurerm_public_ip.single_instance_pub_ip.fqdn}"
}

output "web" {
  value = "http://${azurerm_public_ip.single_instance_pub_ip.fqdn}:<PORT>"
}
