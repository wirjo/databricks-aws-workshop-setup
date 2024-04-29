terraform {
  required_version = ">= 1.4.5"

  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.38.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "databricks" {
  host       = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
}

provider "databricks" {
  alias = "workspace"
  host  = var.databricks_workspace_host
}

provider "aws" {}