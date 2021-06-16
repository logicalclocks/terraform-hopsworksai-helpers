# Hopsworks.ai AWS Helpers module

Terraform sub module that creates the required cloud resources for Hopsworks.ai clusters on AWS.

## Usage Example 

### Default 

By default, the module will generate random names for the resources and automatically create them. It will also use the local public key `~/.ssh/id_rsa.pub` when creating an ssh key pair.

```hcl
terraform {
  required_version = ">= 0.14"
}

locals {
    region = "us-east-2"
}

provider "aws" {
  region = local.region
}

module "aws" {
    source = "logicalclocks/helpers/hopsworksai/modules/aws"
    region = local.region
}
```

It will outputs the names of the created resources

```hcl
module.aws.bucket_name
module.aws.instance_profile_name
module.aws.ssh_key_pair_name
```


### Setting the names

In this example, you can specify the name for different resources as well as your public key.

```hcl
terraform {
  required_version = ">= 0.14"
}

locals {
    region = "us-east-2"
}

provider "aws" {
  region = local.region
}

module "aws" {
    source = "logicalclocks/helpers/hopsworksai/modules/aws"
    region = local.region
    bucket_name = "my-bucket"
    instance_profile_name = "my-instance-profile"
    ssh_key_pair_name = "my-key-pair"
    ssh_public_key = "<YOUR_SSH_PUBLIC_KEY>"
}
```

### Configure Instance profile permissions 

In this example, you can also configure which permissions should be added to the instance profile.

```hcl
terraform {
  required_version = ">= 0.14"
}

locals {
    region = "us-east-2"
}

provider "aws" {
  region = local.region
}

module "aws" {
    source = "logicalclocks/helpers/hopsworksai/modules/aws"
    region = local.region
    instance_profile_permissions = {
        enable_storage     = true
        enable_backup      = true
        enable_cloud_watch = true
        enable_eks_and_ecr = false
        enable_upgrade     = false
    }
}
```