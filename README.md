# Hopsworks.ai Helpers module

Terraform module that creates the required cloud resources for Hopsworks.ai clusters on AWS and AZURE.

## Usage

Sample usage examples with default values, for more configuration check the corresponding sub module for [AWS](./modules/aws) and [AZURE](./modules/azure) 

### AWS Example

Creates an S3 bucket, an SSH key pair, and an instance profile with the required permissions for Hopsworks clusters.

```hcl
module "base" {
    source = "logicalclocks/helpers/hopsworksai"
    use_aws = true
    aws_region = "us-east-2"
}
```
It will outputs the names of the created resources

```hcl
module.base.aws_bucket_name
module.base.aws_instance_profile_name
module.base.aws_ssh_key_pair_name
```

### AZURE Example

Creates a storage account, an SSH key pair, and a user assigned managed identity with the required permissions for Hopsworks clusters.

```hcl
module "base" {
    source = "logicalclocks/helpers/hopsworksai"
    use_azure = true
    azure_resource_group = "<YOUR_RESOURCE_GROUP>"
}
```
It will outputs the names of the created resources

```hcl
module.base.azure_location
module.base.azure_storage_account_name
module.base.azure_user_assigned_identity_name
module.base.azure_ssh_key_pair_name
```