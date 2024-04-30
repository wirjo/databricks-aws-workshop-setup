variable "databricks_account_id" {
  description = "Databricks Account ID"
  type        = string
}
variable "databricks_client_id" {
  type        = string
}

variable "databricks_client_secret" {
  type        = string
}

variable "databricks_metastore_name" {
  description = "Databricks Metastore Name"
  type        = string
  default = "metastore-us-west-2"
}

variable "service_principal_name" {
  description = "Databricks Service Principal name"
  type        = string
  default     = "terraform"
}
variable "region" {
  default     = "us-west-2"
  type        = string
  description = "AWS region to deploy to"
}
resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}
locals {
  prefix = "awsdb-ws-${random_string.naming.result}"
  external_location_name = local.prefix
  databricks_group_name = local.prefix
  databricks_workspace_name = local.prefix
}