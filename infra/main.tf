# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "thingly_app_rg" {
  name     = "thingly-app-rg"
  location = "westus2"
  tags = {
    environment = "production"
  }
}

resource "azurerm_availability_set" "thingly_app_aset" {
  name                = "thingly-app-aset"
  location            = azurerm_resource_group.thingly_app_rg.location
  resource_group_name = azurerm_resource_group.thingly_app_rg.name

  tags = {
    environment = "production"
  }
}

resource "azurerm_virtual_network" "thingly_app_vnet" {
  name          = "thingly-app-vnet"
  address_space = ["10.0.0.0/16"]
  location      = "westus2"
  tags = {
    environment = "production"
  }
  resource_group_name = azurerm_resource_group.thingly_app_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.thingly_app_rg.name
  virtual_network_name = azurerm_virtual_network.thingly_app_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "thingly_app_nic" {
  count               = 4
  name                = "thingly-app-nic-${count.index}"
  location            = azurerm_resource_group.thingly_app_rg.location
  resource_group_name = azurerm_resource_group.thingly_app_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_virtual_machine" "thingly_app_vm" {
  count               = 4
  name                = "thingly-app-vm-${count.index}"
  location            = azurerm_resource_group.thingly_app_rg.location
  resource_group_name = azurerm_resource_group.thingly_app_rg.name
  availability_set_id = azurerm_availability_set.thingly_app_aset.id
  network_interface_ids = [
    azurerm_network_interface.thingly_app_nic[count.index].id
  ]
  vm_size = "Standard_D2_v5"

  storage_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku       = "20_04-lts"
    version   = "20.04.202201310"
  }

  storage_os_disk {
    name          = "thingly-app-os-disk-${count.index}"
    create_option = "FromImage"
    caching       = "ReadWrite"
  }

  os_profile {
    computer_name  = "thingly-app-${count.index}"
    admin_username = "thingly"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/thingly/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa-thingly.net.pub")
    }
  }

  tags = {
    environment = "production"
  }
}
