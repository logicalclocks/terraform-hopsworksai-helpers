output "aws_region" {
  value = var.use_aws ? module.aws_resources.0.region : null
}

output "aws_bucket_name" {
  value = var.use_aws ? module.aws_resources.0.bucket_name : null
}

output "aws_instance_profile_name" {
  value = var.use_aws ? module.aws_resources.0.instance_profile_name : null
}

output "aws_ssh_key_pair_name" {
  value = var.use_aws ? module.aws_resources.0.ssh_key_pair_name : null
}

output "azure_resource_group" {
  value = var.use_azure && var.azure_resource_group != null ? module.azure_resources.0.resource_group : null
}

output "azure_location" {
  value = var.use_azure && var.azure_resource_group != null ? module.azure_resources.0.location : null
}

output "azure_storage_account_name" {
  value = var.use_azure && var.azure_resource_group != null ? module.azure_resources.0.storage_account_name : null
}

output "azure_user_assigned_identity_name" {
  value = var.use_azure && var.azure_resource_group != null ? module.azure_resources.0.user_assigned_identity_name : null
}

output "azure_ssh_key_pair_name" {
  value = var.use_azure && var.azure_resource_group != null ? module.azure_resources.0.ssh_key_pair_name : null
}
