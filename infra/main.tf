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
  tags = {}
}

resource "azurerm_virtual_network" "thingly_app_vnet" {
    name                = "thingly-app-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "westus2"
    tags = {}
    resource_group_name = azurerm_resource_group.thingly_app_rg.name
}
