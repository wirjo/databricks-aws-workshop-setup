variable "databricks_account_id" {
  description = "Databricks Account ID"
  type        = string
}

variable "databricks_workspace_name" {
  type = string
}

variable "databricks_metastore_name" {
  type = string
}
 
variable "region" {
  default     = "us-west-2"
  type        = string
  description = "AWS region to deploy to"
}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

locals {
  prefix = var.databricks_workspace_name
}