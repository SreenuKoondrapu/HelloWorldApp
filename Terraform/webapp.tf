# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend azurerm {
    storage_account_name = "__storageAccountName__"
      container_name       = "$(containerName)"
      key                  = "terraform.tfstate"
    access_key = "__storagekey__"
  }
  
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

#Create Resoure Group
resource "azurerm_resource_group" "helloworld-webapp-rg" {
  name     = "helloworld-webapp-rg"
  location = "Germany West Central"
}

#Create App Service Plan
resource "azurerm_service_plan" "helloworld-asp" {
  name                = "helloworld-serviceplan"
  location            = azurerm_resource_group.helloworld-webapp-rg.location
  resource_group_name = azurerm_resource_group.helloworld-webapp-rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}
#Create Azure App Service
resource "azurerm_app_service" "helloworld-webapplication-asp" {
  name                = "helloworld-webapplication-asp"
  location            = azurerm_resource_group.helloworld-webapp-rg.location
  resource_group_name = azurerm_resource_group.helloworld-webapp-rg.name
  app_service_plan_id = azurerm_service_plan.helloworld-asp.id
}
