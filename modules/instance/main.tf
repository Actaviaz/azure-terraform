# Create a resource group
resource "azurerm_resource_group" "single_instance_rs_grp" {
  name = "${var.resource_grp_name}"
  location = "${var.resource_grp_loc}"
}

# Create a storage account group
resource "azurerm_storage_account" "single_instance_str_acc" {
  name = "${var.storage_account_name}"
  resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
  location = "${azurerm_resource_group.single_instance_rs_grp.location}"
  account_tier = "${var.storage_account_tier}"
  account_replication_type = "${var.storage_account_rep_type}"
}

# Create a security group
resource "azurerm_network_security_group" "single_instance_sc_grp"{
  name = "${var.sec_grp_name}"
  resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
  location = "${azurerm_resource_group.single_instance_rs_grp.location}"
}

# Create security group Outbound rule
resource "azurerm_network_security_rule" "single_instance_sc_outbound_rule" {
    name = "${var.sec_rule_out_name}"
    resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
    network_security_group_name = "${azurerm_network_security_group.single_instance_sc_grp.name}"
    priority = "${var.sec_rule_out_priority}"
    direction = "${var.sec_rule_out_direction}"
    access = "${var.sec_rule_access}"
    protocol = "${var.sec_rule_protocol}"
    source_port_range = "${var.sec_rule_out_source_range}"
    destination_port_range = "${var.sec_rule_out_destination_range}"
    source_address_prefix = "${var.sec_rule_out_source_add_prefix}"
    destination_address_prefix = "${var.sec_rule_out_destination_add_prefix}"
}

# Create security group Inbound rule
resource "azurerm_network_security_rule" "single_instance_sc_inbound_rule" {
    name = "${var.sec_rule_in_name}"
    resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
    network_security_group_name = "${azurerm_network_security_group.single_instance_sc_grp.name}"
    priority = "${var.sec_rule_in_priority}"
    direction = "${var.sec_rule_in_direction}"
    access = "${var.sec_rule_access}"
    protocol = "${var.sec_rule_protocol}"
    source_port_range = "${var.sec_rule_in_source_range}"
    destination_port_ranges = "${var.sec_rule_in_destination_range}"
    source_address_prefix = "${var.sec_rule_in_source_add_prefix}"
    destination_address_prefix = "${var.sec_rule_in_destination_add_prefix}"
}

# Create a network
resource "azurerm_virtual_network" "single_instance_network" {
  name = "${var.network_name}"
  resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
  location = "${azurerm_resource_group.single_instance_rs_grp.location}"
  address_space = "${var.network_address_space}"
  dns_servers = "${var.dns_servers}"
}

# Create a subnet
resource "azurerm_subnet" "single_instance_subnet" {
  name = "${var.subnet_name}"
  resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
  virtual_network_name = "${azurerm_virtual_network.single_instance_network.name}"
  network_security_group_id = "${azurerm_network_security_group.single_instance_sc_grp.id}"
  address_prefix = "${var.subnet_address}"
}

# Create a public IP
resource "azurerm_public_ip" "single_instance_pub_ip" {
  name = "${var.pub_ip_name}"
  location = "${azurerm_resource_group.single_instance_rs_grp.location}"
  resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
  public_ip_address_allocation = "${var.pub_ip_alloc}"
  domain_name_label = "${var.pub_ip_domain_label}"
}

# Create network interface
resource "azurerm_network_interface" "single_instance_nic" {
  name = "${var.nic_name}"
  resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
  location = "${azurerm_resource_group.single_instance_rs_grp.location}"
  ip_configuration {
    name = "${var.nic_ip_conf_name}"
    subnet_id = "${azurerm_subnet.single_instance_subnet.id}"
    private_ip_address_allocation = "${var.nic_ip_alloc}"
    public_ip_address_id = "${azurerm_public_ip.single_instance_pub_ip.id}"
  }
}

# Create the instance
resource "azurerm_virtual_machine" "single_instance" {
  name = "${var.single_instance_name}"
  location = "${azurerm_resource_group.single_instance_rs_grp.location}"
  resource_group_name = "${azurerm_resource_group.single_instance_rs_grp.name}"
  network_interface_ids = ["${azurerm_network_interface.single_instance_nic.id}"]
  vm_size = "${var.single_instance_size}"
  delete_os_disk_on_termination = "${var.delete_os_disk_on_termination}"
  delete_data_disks_on_termination = "${var.delete_data_disks_on_termination}"
  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer = "${var.image_offer}"
    sku = "${var.image_sku}"
    version = "${var.image_version}"
  }
  storage_os_disk {
    name = "${var.os_disk_name}"
    caching = "${var.os_disk_caching}"
    create_option = "${var.os_disk_create}"
    managed_disk_type = "${var.os_disk_type}"
  }
  os_profile {
    computer_name = "${var.single_instance_hostname}"
    admin_username = "${var.instance_admin_user}"
    admin_password = "${var.os_type == "linux" ? "" : var.instance_admin_passwd}"
    custom_data = "${var.os_custom_data}"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/${var.instance_admin_user}/.ssh/authorized_keys"
      key_data = "${file(var.key_path)}"
    }
  }
}
