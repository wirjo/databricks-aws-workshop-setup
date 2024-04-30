locals {
  list_of_instructors = toset(yamldecode(file("${path.module}/config/instructors.yml")).emails)
  list_of_users       = toset(yamldecode(file("${path.module}/config/students.yml")).emails)
}

#########################################
# Create users (from email list)
#########################################

resource "databricks_user" "user" {
  for_each  = local.list_of_users
  user_name = each.key
}

#########################################
# Instructors: group and admin access
#########################################
resource "databricks_group" "aws_instructors" {
  display_name = "${local.databricks_group_name}_instructors"
}

data "databricks_user" "instructors" {
  for_each  = local.list_of_instructors
  user_name = each.key
}

resource "databricks_group_member" "add_instructors_to_group" {
  for_each  = local.list_of_instructors
  group_id  = databricks_group.aws_instructors.id
  member_id = data.databricks_user.instructors[each.key].id
}

#########################################
# Students: group and admin access
#########################################
resource "databricks_group" "aws_event" {
  provider = databricks.mws
  display_name = local.databricks_group_name
}

resource "databricks_group_role" "admin" {
  provider = databricks.mws
  group_id = databricks_group.aws_event.id
  role     = "account_admin"
}

resource "databricks_group_member" "add_users_to_group" {
  provider = databricks.mws
  for_each  = local.list_of_users
  group_id  = databricks_group.aws_event.id
  member_id = databricks_user.user[each.key].id
}

#########################################
# Assign user group to workspace
#########################################
resource "databricks_mws_permission_assignment" "add_group_to_workspace" {
  workspace_id = module.e2.databricks_workspace.workspace_id
  principal_id = databricks_group.aws_event.id
  permissions  = ["ADMIN"]
}

resource "databricks_mws_permission_assignment" "add_instructors_to_workspace" {
  workspace_id = module.e2.databricks_workspace.workspace_id
  principal_id = databricks_group.aws_instructors.id
  permissions  = ["ADMIN"]
}

resource "databricks_mws_permission_assignment" "add_service_principal_to_workspace" {
  workspace_id = module.e2.databricks_workspace.workspace_id
  principal_id = data.databricks_service_principal.terraform.id
  permissions  = ["ADMIN"]
}

resource "databricks_entitlements" "workspace_group_entitlements" {
  provider = databricks.mws
  group_id              = databricks_group.aws_event.id
  allow_cluster_create  = true
  databricks_sql_access = true
  workspace_access      = true
}