# Define variables
variable "service_name" {
  description = "Desired name for the provisioned resources"
  type        = string
  default     = "Services"
}

variable "service_environment" {
  description = "Desired environment for the service collection of provisioned resources"
  type        = string
  default     = "Test"
}

variable "service_location" {
  description = "The production resource locations to deploy"
  type        = string
  default     = "UK South"
}

variable "service_deployment" {
  description = "Desired deployment identifier of the service collection of provisioned resources"
  type        = string
}

variable "resource_name" {
  description = "Desired name for the provisioned resources"
  type        = map(string)
  default = {
    "Services" = "TST"
  }
}

variable "resource_address_space" {
  description = "Desired address space for the provisioned resources"
  type        = string
  default     = "10.0.2.0/24"
}

variable "resource_dns_servers" {
  description = "Desired DNS servers for the provisioned resources"
  type        = list(string)
  default = [
    "10.0.2.4",
    "10.0.2.5"
  ]
}

variable "resource_network_subnet_count" {
  description = "Desired number of subnets"
  type        = string
  default     = 1
}

variable "resource_network_role" {
  description = "The network type for peering"
  type        = string
  default     = "spoke"
}
