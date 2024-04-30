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
  alias = "mws"
  host = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  client_id = "d08cdf2b-ce97-421e-a7cf-7dcc23ef48fd"
  client_secret = "dose6b00cdf2a30f71ff4cb4af941a05ebb8"
}