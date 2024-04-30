resource "databricks_external_location" "external" {
  provider        = databricks.workspace

  for_each        = local.list_of_users
  name            = "external_${aws_s3_object.user_home[each.key].key}"
  url             = "s3://${aws_s3_bucket.external.id}/${aws_s3_object.user_home[each.key].key}"
  credential_name = databricks_storage_credential.external.id
  comment         = "Managed by Terraform"

  depends_on = [
    time_sleep.wait,
    databricks_mws_permission_assignment.add_service_principal_to_workspace
  ]
}

# This workaround fixes the IAM role / policy propagation delay.
# The following error can happen in case we don't apply this technique:
#
# Error: cannot create external location: AWS IAM role does not have
#  READ permissions on url s3://<bucket_name>/<user_home_folder>.
#  Please contact your account admin to update the storage credential.
#
# Solution suggested via Databricks Knowledge Base and available here:
#  https://kb.databricks.com/terraform/failed-credential-validation-checks-error-with-terraform
resource "time_sleep" "wait" {
  create_duration = "30s"
  depends_on = [
    databricks_storage_credential.external,
    aws_iam_role.external,
  ]
}

resource "databricks_storage_credential" "external" {
  provider = databricks.workspace
  name     = aws_iam_role.external.name
  comment  = "Managed by Terraform"

  aws_iam_role {
    role_arn = aws_iam_role.external.arn
  }
}

resource "databricks_grant" "external_service_principal" {
  provider           = databricks.workspace
  storage_credential = databricks_storage_credential.external.id

  principal = data.databricks_service_principal.terraform.application_id
  privileges = [
    "CREATE_EXTERNAL_LOCATION",
    "CREATE_EXTERNAL_TABLE"
  ]
}

resource "databricks_grant" "external_user" {
  provider          = databricks.workspace
  for_each          = local.list_of_users
  external_location = databricks_external_location.external[each.key].id

  principal = each.key
  privileges = [
    "ALL_PRIVILEGES"
  ]
}

resource "databricks_grant" "external_instructor" {
  provider          = databricks.workspace
  for_each          = local.list_of_users
  external_location = databricks_external_location.external[each.key].id

  principal = databricks_group.aws_instructors.display_name
  privileges = [
    "ALL_PRIVILEGES"
  ]
}