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
    environment = "Production"
  }
}

resource "azurerm_virtual_network" "thingly_app_vnet" {
  name          = "thingly-app-vnet"
  address_space = ["10.0.0.0/16"]
  location      = "westus2"
  tags = {
    environment = "Production"
  }
  resource_group_name = azurerm_resource_group.thingly_app_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.thingly_app_rg.name
  virtual_network_name = azurerm_virtual_network.thingly_app_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_availability_set" "thingly_app_aset" {
  name                = "thingly-app-aset"
  location            = azurerm_resource_group.thingly_app_rg.location
  resource_group_name = azurerm_resource_group.thingly_app_rg.name

  tags = {
    environment = "Production"
  }
}
