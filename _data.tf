data "aws_caller_identity" "current" {}
data "databricks_metastores" "all" {
}
data "databricks_service_principal" "terraform" {
  display_name = var.service_principal_name
}