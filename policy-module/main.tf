terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }
  }


   cloud {
     organization = var.organization
     workspaces {
        name = var.workspace_name
        }
   } 
  
}

provider "azurerm" {
  features {}
}

# Data source to get current subscription information
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "restrict_location_policy" {
  name         = var.policy_name
  policy_type  = "Custom"
  mode         = "All"
  display_name = var.policy_display_name
  policy_rule  = file("${path.module}/restrict-region-policy.json")

}

resource "azurerm_subscription_policy_assignment" "policy_assignmnet" {
  name                   = var.policy_assignment_name
  policy_definition_id   = azurerm_policy_definition.restrict_location_policy.id  
  subscription_id        = data.azurerm_subscription.current.id
  description            = var.policy_assignmnet_description
  display_name           = var.policy_assignment_display_name
}