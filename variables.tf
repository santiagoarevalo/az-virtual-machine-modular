variable "prefix" {
  type        = string
  description = "Project Name, prefix of the resources names"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Location"
}

variable "user" {
  type        = string
  default     = "santiago_vm_modular03"
  description = "Virtual Machine Username"
}

variable "password" {
  type        = string
  default     = "Password1234!"
  description = "Virtual Machine Password for the ssh connection"
}