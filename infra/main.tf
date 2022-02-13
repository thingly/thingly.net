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

resource "azurerm_resource_group" "rg" {
  name     = "thingly-rg"
  location = "westus2"

  tags = {
    environment = "production"
  }
}

resource "azurerm_app_service_plan" "asp" {
  name                = "thingly-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_app_service" "app" {
  name                = "thingly-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  source_control {
    repo_url = "https://github.com/thingly/thingly.net"
    branch   = "main"
  }

  site_config {
    python_version = "3.4"
  }

  tags = {
    environment = "production"
  }
}
