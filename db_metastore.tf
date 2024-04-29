resource "databricks_grants" "metastore_group_permissions" {
  provider  = databricks.workspace
  metastore = data.databricks_metastores.all.ids[var.databricks_metastore_name]

  grant {
    principal = databricks_group.aws_event.display_name
    privileges = [
      "CREATE_CATALOG",
      "CREATE_EXTERNAL_LOCATION",
      "CREATE_STORAGE_CREDENTIAL"
    ]
  }
}