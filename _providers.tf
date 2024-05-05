terraform {
  required_version = ">= 1.4.5"
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.38.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
  }
}

provider "databricks" {
  host = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  client_id = var.databricks_client_id
  client_secret =  var.databricks_client_secret
}
provider "databricks" {
  alias = "mws"
  host = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  client_id = var.databricks_client_id
  client_secret =  var.databricks_client_secret
}
provider "databricks" {
  alias = "workspace"
  host  = module.e2.databricks_host
  client_id = var.databricks_client_id
  client_secret =  var.databricks_client_secret
}
provider "aws" {
  region = var.region
}