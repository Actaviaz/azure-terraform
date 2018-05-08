output "resource_group_id" {
  value = "${azurerm_resource_group.single_instance_rs_grp.id}"
}

output "storage_account_id"{
  value = "${azurerm_storage_account.single_instance_str_acc.id}"
}

output "network_id" {
  value = "${azurerm_virtual_network.single_instance_network.id}"
}

output "security_group_id" {
  value = "${azurerm_network_security_group.single_instance_sc_grp.id}"
}

output "instance_nic_id" {
  value = "${azurerm_network_interface.single_instance_nic.id}"
}

output "public_ip" {
  value = "${azurerm_public_ip.single_instance_pub_ip.ip_address}"
}

output "public_ip_fqdn" {
  value = "${azurerm_public_ip.single_instance_pub_ip.fqdn}"
}

output "admin_user" {
  value = "${var.instance_admin_user}"
}

output "admin_password" {
  value = "${var.os_type == "linux" ? "Use private key" : var.instance_admin_passwd}"
}
