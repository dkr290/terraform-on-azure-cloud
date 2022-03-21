variable "business_division" {
    type = string
    description = "BD in large organization this infra belongs"
    default = "sap"
    
}

variable "environment" {
    description = "Environment variable used as prefix"
    default = "dev"
}

variable "resource_group_name" {
    description = "Resource Group Name"
    default = "test-RG"
  
}

variable "resource_group_location" {
   description = "Region where the azure resources will be created"   
   default = "northeurope"
}

