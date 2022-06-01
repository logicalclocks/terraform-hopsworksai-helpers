terraform {
  required_version = ">= 0.14"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.8.0"
    }

    hopsworksai = {
      source  = "logicalclocks/hopsworksai"
      version = ">= 0.10.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.2.0"
    }
  }
}