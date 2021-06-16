
resource "random_string" "suffix" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

locals {
  resource_group              = var.resource_group
  storage_account_name        = var.storage_account_name != null ? var.storage_account_name : "tfstorageaccount${random_string.suffix.result}"
  user_assigned_identity_name = var.user_assigned_identity_name != null ? var.user_assigned_identity_name : "tf-managed-identity-${random_string.suffix.result}"
  ssh_key_pair_name           = var.ssh_key_pair_name != null ? var.ssh_key_pair_name : "tf-key-pair-${random_string.suffix.result}"
  ssh_public_key              = var.ssh_public_key != null ? var.ssh_public_key : file("~/.ssh/id_rsa.pub")
}


data "azurerm_resource_group" "rg" {
  name = local.resource_group
}

# Create storage account 
resource "azurerm_storage_account" "storage" {
  name                     = local.storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}

# Create user assigned identity with hopsworks.ai permissions
resource "azurerm_user_assigned_identity" "identity" {
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  name                = local.user_assigned_identity_name
}

# Add permissions to the user assigned identity
# add storage permissions on the storage account 
data "hopsworksai_azure_user_assigned_identity_permissions" "storage_policy" {
  count              = var.user_assigned_identity_permissions.enable_storage || var.user_assigned_identity_permissions.enable_backup ? 1 : 0
  enable_storage     = var.user_assigned_identity_permissions.enable_storage
  enable_backup      = var.user_assigned_identity_permissions.enable_backup
  enable_aks_and_acr = false
  enable_upgrade     = false
}

resource "azurerm_role_definition" "storage_role" {
  count = var.user_assigned_identity_permissions.enable_storage || var.user_assigned_identity_permissions.enable_backup ? 1 : 0
  name  = "${local.user_assigned_identity_name}-storage-role"
  scope = azurerm_storage_account.storage.id
  permissions {
    actions          = data.hopsworksai_azure_user_assigned_identity_permissions.storage_policy.0.actions
    not_actions      = data.hopsworksai_azure_user_assigned_identity_permissions.storage_policy.0.not_actions
    data_actions     = data.hopsworksai_azure_user_assigned_identity_permissions.storage_policy.0.data_actions
    not_data_actions = data.hopsworksai_azure_user_assigned_identity_permissions.storage_policy.0.not_data_actions
  }
}

resource "azurerm_role_assignment" "storage_role_assignment" {
  count              = var.user_assigned_identity_permissions.enable_storage || var.user_assigned_identity_permissions.enable_backup ? 1 : 0
  scope              = azurerm_storage_account.storage.id
  role_definition_id = azurerm_role_definition.storage_role.0.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.identity.principal_id
}

# add upgrade and aks/acr permissions on the resource group
data "hopsworksai_azure_user_assigned_identity_permissions" "resource_group_policy" {
  count              = var.user_assigned_identity_permissions.enable_aks_and_acr || var.user_assigned_identity_permissions.enable_upgrade ? 1 : 0
  enable_storage     = false
  enable_backup      = false
  enable_aks_and_acr = var.user_assigned_identity_permissions.enable_aks_and_acr
  enable_upgrade     = var.user_assigned_identity_permissions.enable_upgrade
}

resource "azurerm_role_definition" "rg_role" {
  count = var.user_assigned_identity_permissions.enable_aks_and_acr || var.user_assigned_identity_permissions.enable_upgrade ? 1 : 0
  name  = "${local.user_assigned_identity_name}-rg-role"
  scope = data.azurerm_resource_group.rg.id
  permissions {
    actions          = data.hopsworksai_azure_user_assigned_identity_permissions.resource_group_policy.0.actions
    not_actions      = data.hopsworksai_azure_user_assigned_identity_permissions.resource_group_policy.0.not_actions
    data_actions     = data.hopsworksai_azure_user_assigned_identity_permissions.resource_group_policy.0.data_actions
    not_data_actions = data.hopsworksai_azure_user_assigned_identity_permissions.resource_group_policy.0.not_data_actions
  }
}

resource "azurerm_role_assignment" "rg_role_assignment" {
  count              = var.user_assigned_identity_permissions.enable_aks_and_acr || var.user_assigned_identity_permissions.enable_upgrade ? 1 : 0
  scope              = data.azurerm_resource_group.rg.id
  role_definition_id = azurerm_role_definition.rg_role.0.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.identity.principal_id
}


# Create an ssh key pair 
resource "azurerm_ssh_public_key" "key" {
  name                = local.ssh_key_pair_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  public_key          = local.ssh_public_key
}