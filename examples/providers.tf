# Set required providers and versions
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure Providers
provider "azurerm" {
  features {
    virtual_machine {
      skip_shutdown_and_force_delete = true
    }

    # Workaround OS disk being retained after VM delete operation
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
