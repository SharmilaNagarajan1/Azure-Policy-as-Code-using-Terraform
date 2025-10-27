terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }
  }


   cloud {
     organization = "Sharmila"
     workspaces {
        name = "azure-policy-module"
        }
   } 
  
}

provider "azurerm" {
  features {}
}

# Data source to get current subscription information
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "location_policy" {
  name         = "deny-non-east-us-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allow only East US location for resources"


  policy_rule = <<POLICY_RULE
 {
    "if": {
      "not": {
        "field": "location",
         "equals": "eastus"
      }
    },
    "then": {
      "effect": "deny"
    }
  }
POLICY_RULE

}

resource "azurerm_subscription_policy_assignment" "policy_assignmnet" {
  name                   = "deny-non-east-us-locations-assignment"
  policy_definition_id   = azurerm_policy_definition.location_policy.id  
  subscription_id        = data.azurerm_subscription.current.id
  description            = "Policy assignment to restrict resource creation to East US location only"
}