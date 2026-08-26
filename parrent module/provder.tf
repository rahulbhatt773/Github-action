terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rahul_rg"
    storage_account_name = "rahulsto"
    container_name       = "rahulblob"
    key                  = "rahul.tfstate"
  }
}

provider "azurerm" {
  features {}

}
