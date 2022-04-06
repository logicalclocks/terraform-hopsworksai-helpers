terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }

    hopsworksai = {
      source  = "logicalclocks/hopsworksai"
      version = ">= 0.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}