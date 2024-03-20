provider "azurerm" {
  features {}
}

# Create the resource group 
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create the first subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-sn1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Declare the module for the virtual machine
module "vm" {
  source    = "./modules/vm"
  prefix    = var.prefix
  subnet-id = azurerm_subnet.subnet.id
  location  = var.location
  user      = var.user
  password  = var.password
}