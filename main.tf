module "e2" {
    source = "./e2"
    databricks_account_id = var.databricks_account_id
    databricks_workspace_name = local.databricks_group_name
    databricks_metastore_name = var.databricks_metastore_name
    databricks_client_id = var.databricks_client_id
    databricks_client_secret = var.databricks_client_secret
}