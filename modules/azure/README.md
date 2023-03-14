# Hopsworks.ai AZURE Helpers module

Terraform sub module that creates the required cloud resources for Hopsworks.ai clusters on AZURE.

## Usage Example 

### Default 

By default, the module will generate random names for the resources and automatically create them. It will also use the local public key `~/.ssh/id_rsa.pub` when creating an ssh key pair.

```hcl
terraform {
  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "azure" {
    source = "logicalclocks/helpers/hopsworksai//modules/azure"
    resource_group = "<YOUR_RESOURCE_GROUP>"
}
```

It will outputs the names of the created resources

```hcl
module.azure.storage_account_name
module.azure.user_assigned_identity_name
module.azure.ssh_key_pair_name
```

### Setting the names

In this example, you can specify the name for different resources as well as your public key.

```hcl
terraform {
  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "azure" {
    source = "logicalclocks/helpers/hopsworksai//modules/azure"
    resource_group = "<YOUR_RESOURCE_GROUP>"
    storage_account_name = "mystorageaccount"
    user_assigned_identity_name = "my-user-assigned-managed-identity"
    ssh_key_pair_name = "my-key-pair"
    ssh_public_key = "<YOUR_SSH_PUBLIC_KEY>"
}
```

### Configure User assigned managed identity permissions 

In this example, you can also configure which permissions should be added to the user assigned managed identity.

```hcl
terraform {
  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "azure" {
    source = "logicalclocks/helpers/hopsworksai//modules/azure"
    resource_group = "<YOUR_RESOURCE_GROUP>"
    user_assigned_identity_permissions = {
        enable_storage     = true
        enable_backup      = true
        enable_acr         = false
        enable_aks         = true
    }
}
```