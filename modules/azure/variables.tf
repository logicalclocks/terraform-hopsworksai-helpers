variable "resource_group" {
  description = "The default resource group where we will create the resources (ssh key pair and s3 bucket)."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account to create. If not supplied a random name will be used."
  type        = string
  default     = null
}

variable "user_assigned_identity_name" {
  description = "The name of the user assigned managed identity to create. If not supplied a random name will be used."
  type        = string
  default     = null
}

variable "user_assigned_identity_permissions" {
  description = "Enable the different permissions required to by Hopsworks clusters."
  type = object({
    enable_storage = bool
    enable_backup  = bool
    enable_aks     = bool
    enable_acr     = bool
  })
  default = {
    enable_storage = true
    enable_backup  = true
    enable_aks     = true
    enable_acr     = true
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
