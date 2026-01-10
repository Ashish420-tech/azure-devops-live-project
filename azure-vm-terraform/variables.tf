variable "location" {
  default = "west Europe"
}

variable "resource_group_name" {
  default = "rg-azure-devops-vm"
}

variable "vm_name" {
  default = "azure-devops-vm"
}

variable "admin_username" {
  default = "azureuser"
}

variable "ssh_public_key" {}
