# /infra/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-webapp-demo"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "UK South"
}

variable "app_name_prefix" {
  description = "A unique prefix for naming resources."
  type        = string
  default     = "mywebapp" # CHANGE THIS to something unique
}