terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "resource_group" {
  source = "../../"

  name     = "rg-example-dev"
  location = "East US"

  tags = {
    Environment = "dev"
    Project     = "iac-atom-resourcegroup"
    ManagedBy   = "terraform"
  }
}

output "resource_group_details" {
  value = {
    id       = module.resource_group.resource_group_id
    name     = module.resource_group.resource_group_name
    location = module.resource_group.location
  }
}