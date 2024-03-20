variable "prefix" {
  type        = string
  description = "Project Name, prefix of the resources names"
}

variable "subnet-id" {
  type        = string
  description = "Subnet Id or name"
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "Location"
}

variable "user" {
  type        = string
  default     = "santiago_vm_modular03"
  description = "Admin user"
}

variable "password" {
  type        = string
  default     = "Password1234!"
  description = "Admin password"
}