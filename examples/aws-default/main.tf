terraform {
  required_version = ">= 0.14"
}

variable "region" {
  description = "AWS Region"
  type        = string
}

provider "aws" {
  region = var.region
}

module "aws" {
  source = "../../modules/aws"
  region = var.region
}

output "bucket_name" {
  value = module.aws.bucket_name
}

output "instance_profile_name" {
  value = module.aws.instance_profile_name
}

output "instance_profile_arn" {
  value = module.aws.instance_profile_arn
}

output "instance_profile_role_arn" {
  value = module.aws.instance_profile_role_arn
}

output "ssh_key_pair_name" {
  value = module.aws.ssh_key_pair_name
}