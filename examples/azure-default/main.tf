terraform {
  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
}

module "azure" {
  source         = "../../modules/azure"
  resource_group = var.resource_group
}

output "storage_account_name" {
  value = module.azure.storage_account_name
}

output "user_assigned_identity_name" {
  value = module.azure.user_assigned_identity_name
}

output "ssh_key_pair_name" {
  value = module.azure.ssh_key_pair_name
}