terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.8.0"
    }

    hopsworksai = {
      source  = "logicalclocks/hopsworksai"
      version = ">= 1.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.2.0"
    }
  }
}