terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "c0e1516f-006f-46c5-8497-00cd3b06da78"
  tenant_id = "101f87a7-6d6b-4c6c-9d9c-223592a2ba50"
}