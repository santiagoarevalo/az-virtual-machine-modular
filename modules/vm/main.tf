#Assign a public IP address to the VM
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-pi"
  resource_group_name =  "${var.prefix}-rg"
  location            = var.location
  allocation_method   = "Static"
}

# Create the network interface
resource "azurerm_network_interface" "net-interface" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = "${var.prefix}-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet-id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

# Create the security group and the rule to allow SSH
resource "azurerm_network_security_group" "sg" {
  name                = "${var.prefix}-sg"
  location            = var.location
  resource_group_name = "${var.prefix}-rg"

  security_rule {
    name                        = "AllowSSH"
    priority                    = 1001
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

# Associate the network interface with the security group
resource "azurerm_network_interface_security_group_association" "nisga" {
  network_interface_id      = azurerm_network_interface.net-interface.id
  network_security_group_id = azurerm_network_security_group.sg.id
}

# Create the virtual machine
resource "azurerm_virtual_machine" "vm_name" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = "${var.prefix}-rg"
  network_interface_ids = [azurerm_network_interface.net-interface.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.user
    admin_password = var.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}