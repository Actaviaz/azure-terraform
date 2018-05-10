variable "resource_grp_name" {
  description = "Name of the resource group."
  default = "single_inst_rsgrp"
}

variable "resource_grp_loc" {
  description = "Location of the resource group."
  default = "westeurope"
}

variable "storage_account_name" {
  description = "Name of the storage account."
  default = "singleinststracc"
}

variable "storage_account_tier" {
  description = "Tier type for the storage account."
  default = "Standard"
}

variable "storage_account_rep_type" {
  description = "Replication type for the storage account."
  default = "GRS"
}

variable "network_name" {
  description = "Name of the network."
  default = "single_instance_network"
}

variable "network_address_space" {
  description = "Address space for the network. Subnets will belong to this address space."
  default = ["192.168.0.0/16"]
}

variable "dns_servers" {
  description = "DNS servers for the network."
  default = []
}

variable "sec_grp_name" {
  description = "Name of the security group."
  default = "single_instance_sc_grp"
}

variable "sec_grp_loc" {
  description = "Location for the security group"
  default = "westeurope"
}

variable "sec_rule_out_name" {
  description = "Name for the security group rule"
  default = "Outbound access for TCP"
}

variable "sec_rule_out_priority" {
  description = "Defines the rule priority. The value can be between 100 and 4096. Must be unique! Lower has more priority."
  default = "100"
}

variable "sec_rule_out_direction" {
  description = "Direction of the rule. Possible values are Inbound and Outbound."
  default = "Outbound"
}

variable "sec_rule_access" {
  description = "Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."
  default = "Allow"
}

variable "sec_rule_protocol" {
  description = "Protocol used in the rule. Possible values include Tcp, Udp or *."
  default = "Tcp"
}

variable "sec_rule_out_source_range" {
  description = "Source Port or Range. Integer or range between 0 and 65535 or * to match any."
  default = "*"
}

variable "sec_rule_out_destination_range" {
  description = "Destination Port or Range. Integer or range between 0 and 65535 or * to match any."
  default = "*"
}

variable "sec_rule_out_source_add_prefix" {
  description = "CIDR or source IP range or * to match any IP. Can use tags for network resources."
  default = "*"
}

variable "sec_rule_out_destination_add_prefix" {
  description = "CIDR or destination IP range or * to match any IP. Can use tags for network resources."
  default = "*"
}

variable "sec_rule_in_name" {
  description = "Name for the security group rule"
  default = "Inbound access for SSH"
}

variable "sec_rule_in_priority" {
  description = "Defines the rule priority. The value can be between 100 and 4096. Must be unique! Lower has more priority."
  default = "101"
}

variable "sec_rule_in_direction" {
  description = "Direction of the rule. Possible values are Inbound and Outbound."
  default = "Inbound"
}

variable "sec_rule_in_source_range" {
  description = "Source Port or Range. Integer or range between 0 and 65535 or * to match any."
  default = "*"
}

variable "sec_rule_in_destination_range" {
  type = "list"
  description = "Destination Port or Range. Integer or range between 0 and 65535 or * to match any."
  default = ["22"]
}

variable "sec_rule_in_source_add_prefix" {
  description = "CIDR or source IP range or * to match any IP. Can use tags for network resources."
  default = "*"
}

variable "sec_rule_in_destination_add_prefix" {
  description = "CIDR or destination IP range or * to match any IP. Can use tags for network resources."
  default = "*"
}

variable "subnet_name" {
  description = "Name of the subnet."
  default = "single_instance_subnet"
}

variable "subnet_address" {
  description = "Address prefix for the subnet."
  default = "192.168.1.0/24"
}

variable "nic_name" {
  description = "Name of the NIC for the instance."
  default = "single_inst_nic"
}

variable "nic_ip_alloc" {
  description = "NIC private IP allocation."
  default = "dynamic"
}

variable "nic_ip_conf_name" {
  description = "Name of the subnet configuration for the NIC."
  default = "single_inst_nic_conf"
}

variable "pub_ip_name" {
  description = "Name of the public IP."
  default = "single_inst_pub_ip"
}

variable "pub_ip_alloc" {
  description = "Allocation for the public IP."
  default = "static"
}

variable "pub_ip_domain_label" {
  description = "DNS label for the public IP."
  default = "single-inst"
}

variable "single_instance_name" {
  description = "Name of the instance."
  default = "single_instance"
}

variable "single_instance_size" {
  description = "VM size."
  default = "Standard_DS1_v2"
}

variable "delete_os_disk_on_termination" {
  description = "Flag that marks if the OS disk is deleted on VM delete."
  default = true
}

variable "delete_data_disks_on_termination" {
  description = "Flag that marks if the data disks are deleted on VM delete."
  default = true
}

variable "os_type" {
  description = "Sets the OS type. Used to set a user password."
  default = "linux"
}

variable "image_publisher" {
  description = "Publisher for the OS image."
  default = "Canonical"
}

variable "image_offer" {
  description = "Offer for the OS image."
  default = "UbuntuServer"
}

variable "image_sku" {
  description = "SKU for the OS image."
  default = "16.04-LTS"
}

variable "image_version" {
  description = "Version for the OS image."
  default = "latest"
}

variable "os_disk_name" {
  description = "Name of the OS disk."
  default = "singleinstosdisk"
}

variable "os_disk_caching" {
  description = "Caching of the OS disk."
  default = "ReadWrite"
}

variable "os_disk_create" {
  description = "Source from where the disk is created."
  default = "FromImage"
}

variable "os_disk_type" {
  description = "Type of the disk. Can be Standard_LRS or Premium_LRS."
  default = "Standard_LRS"
}

variable "single_instance_hostname" {
  description = "Instance hostname."
  default = "SingleInstance"
}

variable "instance_admin_user" {
  description = "Name of the Admin user."
  default = "inst_adm"
}

variable "instance_admin_passwd" {
  description = "Name of the Admin user."
  default = "Password1234!"
}

variable "key_path" {
  description = "Path to the public key for ssh auth."
  default = "keys/linux_key.pub"
}

variable "os_custom_data" {
  description = "Adds custom data to the cloud init script."
  default = ""
}
