resource "databricks_grant" "metastore_group_permissions" {
  provider  = databricks.workspace
  metastore = data.databricks_metastores.all.ids[var.databricks_metastore_name]
  principal = databricks_group.aws_event.display_name
  privileges = [
    "CREATE_CATALOG",
    "CREATE_EXTERNAL_LOCATION",
    "CREATE_STORAGE_CREDENTIAL"
  ]
}
resource "databricks_grant" "metastore_service_principal_permissions" {
  provider  = databricks.workspace
  metastore = data.databricks_metastores.all.ids[var.databricks_metastore_name]
  principal = var.service_principal_name
  privileges = [
    "CREATE_CATALOG",
    "CREATE_EXTERNAL_LOCATION",
    "CREATE_STORAGE_CREDENTIAL"
  ]
}