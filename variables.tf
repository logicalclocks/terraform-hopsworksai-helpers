variable "aws_region" {
  description = "The default AWS region where we will create the resources (ssh key pair and s3 bucket)."
  type        = string
  default     = "us-east-2"
}

variable "azure_resource_group" {
  description = "The default resource group where we will create the resources (ssh key pair and s3 bucket)."
  type        = string
  default     = null
}

variable "use_aws" {
  description = "Create the required clouds resource for Hopsworks.ai on AWS."
  type        = bool
  default     = false
}

variable "use_azure" {
  description = "Create the required clouds resource for Hopsworks.ai on AZURE."
  type        = bool
  default     = false
}