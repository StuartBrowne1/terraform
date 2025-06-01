variable "location" {
  default = "eastus"
}

variable "resource_group_name" {
  default = "landingzone-rg"
}

variable "vnet_name" {
  default = "landingzone-vnet"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    {
      name           = "subnet-management"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "subnet-workload"
      address_prefix = "10.0.2.0/24"
    }
  ]
}
