
resource "random_string" "suffix" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

locals {
  bucket_name           = var.bucket_name != null ? var.bucket_name : "tf-bucket-${random_string.suffix.result}"
  instance_profile_name = var.instance_profile_name != null ? var.instance_profile_name : "tf-instance-profile-${random_string.suffix.result}"
  ssh_key_pair_name     = var.ssh_key_pair_name != null ? var.ssh_key_pair_name : "tf-key-pair-${random_string.suffix.result}"
  ssh_public_key        = var.ssh_public_key != null ? var.ssh_public_key : file("~/.ssh/id_rsa.pub")
}

# Create instance profile with the required hopsworks permissions
data "hopsworksai_aws_instance_profile_policy" "policy" {
  bucket_name        = local.bucket_name
  enable_storage     = var.instance_profile_permissions.enable_storage
  enable_backup      = var.instance_profile_permissions.enable_backup
  enable_cloud_watch = var.instance_profile_permissions.enable_cloud_watch
  enable_eks         = var.instance_profile_permissions.enable_eks
  enable_ecr         = var.instance_profile_permissions.enable_ecr
}

resource "aws_iam_role" "role" {
  name = "${local.instance_profile_name}-role"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
    }
  )

  inline_policy {
    name   = "hopsworksai"
    policy = data.hopsworksai_aws_instance_profile_policy.policy.json
  }
}

resource "aws_iam_instance_profile" "profile" {
  name = local.instance_profile_name
  role = aws_iam_role.role.name
}

data "aws_iam_instance_profile" "profile" {
  name = aws_iam_instance_profile.profile.name
}

# Create an S3 bucket and block all public access to it
resource "aws_s3_bucket" "bucket" {
  bucket        = local.bucket_name
  force_destroy = true
}

# Create an ssh key pair
resource "aws_key_pair" "key" {
  key_name   = local.ssh_key_pair_name
  public_key = local.ssh_public_key
}
