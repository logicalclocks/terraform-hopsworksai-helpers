
provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "aws_resources" {
  count  = var.use_aws ? 1 : 0
  source = "./modules/aws"
  region = var.aws_region
}

module "azure_resources" {
  count          = var.use_azure && var.azure_resource_group != null ? 1 : 0
  source         = "./modules/azure"
  resource_group = var.azure_resource_group
}
