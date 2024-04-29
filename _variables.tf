variable "databricks_account_id" {
  description = "Databricks Account ID"
  type        = string
}

variable "databricks_workspace_name" {
  description = "Databricks Workspace Name"
  type        = string
}

variable "databricks_workspace_host" {
  description = "Databricks Workspace Host URL"
  type        = string
}

variable "databricks_metastore_name" {
  description = "Databricks Metastore Name"
  type        = string
}

variable "service_principal_name" {
  description = "Databricks Service Principal name"
  type        = string
  default     = "terraform"
}

variable "external_location_name" {
  description = "Databricks External Location name"
  type        = string
  default     = "databricks-workshop-external-location"
}

variable "databricks_group_name" {
  description = "Databricks Group name"
  type        = string
  default     = "aws_workshop"
}