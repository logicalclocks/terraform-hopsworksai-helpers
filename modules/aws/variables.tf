variable "region" {
  description = "The default AWS region where we will create the resources (ssh key pair and s3 bucket)."
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create. If not supplied a random name will be used."
  type        = string
  default     = null
}

variable "instance_profile_name" {
  description = "The name of the instance profile to create. If not supplied a random name will be used."
  type        = string
  default     = null
}

variable "instance_profile_permissions" {
  description = "Enable the different permissions required to by Hopsworks clusters."
  type = object({
    enable_storage     = bool
    enable_backup      = bool
    enable_cloud_watch = bool
    enable_eks         = bool
    enable_ecr         = bool
  })
  default = {
    enable_storage     = true
    enable_backup      = true
    enable_cloud_watch = true
    enable_eks         = true
    enable_ecr         = true
  }
}

variable "ssh_key_pair_name" {
  description = "The name of the ssh key pair to be created. If not supplied a random name will be used."
  type        = string
  default     = null
}

variable "ssh_public_key" {
  description = "The public key to use with the ssh key pair. If not supplied we will use the ~/.ssh/id_rsa.pub if it exists."
  type        = string
  default     = null
}
