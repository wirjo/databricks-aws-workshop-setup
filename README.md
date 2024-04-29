# Databricks + AWS workshop | Terraform setup

## Pre-requisites

* See [Workshop Admin Guide](https://catalog.workshops.aws/dare-genai-rag-databricks/en-US/lab-0-setup/04-admin-guide)

* Copy and paste `setup.sh` and run it on AWS CloudShell

## Manual step: Create a new service principal to run Terraform scripts

1. Access `https://accounts.cloud.databricks.com`.
1. In the left menu open `User Management` and the tab `Service principals`.
1. Create a new service principal with name `terraform`.
1. Edit the service principal and create an `OAuth secret`. Store the client ID and secret for later use.
1. Ensure that the service principal has admin access to the Databricks account. To do this, go to the Roles tab.
2. Ensure that the service principal has admin access to the Databricks workspace. To do this, go to Workspaces -> select the workspace -> add permissions.


## (Optional) Manual step: Metastore permissions

This is now automated by `db_metastore.tf`. However, a manual step can be made if necessary:

1. Access the Databricks workspace and open the **Catalog** section.
1. Update the global permissions and grant the service principal `terraform` the following permissions:

```
CREATE_CATALOG
CREATE_EXTERNAL_LOCATION
CREATE_STORAGE_CREDENTIAL
```

1. Wait a few minutes and permissions can take some time to propagate.

## Configure Terraform credentials (local machine)

1. Create a copy of `.env.template` to `.env` and provide values for:
    1. `DATABRICKS_CLIENT_ID` and `DATABRICKS_CLIENT_SECRET` referencing the OAuth secret created previously.
    1. `TF_VAR_databricks_account_id` referencing the Databricks Account ID, available in the right upper section of the Databricks console.
    1. `TF_VAR_databricks_workspace_name` referencing the Databricks Workspace Name. The internal ID is collected automatically by Terraform.
    1. `TF_VAR_databricks_workspace_host` referencing the Databricks Workspace Host URL (e.g. https://<YOUR_WORKSPACE>.cloud.databricks.com/).
    1. `TF_VAR_databricks_metastore_name` referencing the Databricks Metastore Name. The internal ID is collected automatically by Terraform.
    1. `TF_VAR_databricks_service_principal_name` referencing the Databricks service principal that Terraform will use. For example, you can name it `terraform`.
    1. `TF_VAR_databricks_external_location_name` referencing the Databricks external location that Terraform will use. This also determines the S3 bucket name so you need to provide a unique name per workshop event `aws-db-ws-xxxxxxxx`.
    1. `TF_VAR_databricks_group_name` referencing the Databricks group that Terraform will use. For example, you can provide a unique name per workshop event `aws-db-ws-xxxxxxxx`.

1. When configured, load the environment variables with command `source .env`.

## Authenticate to the AWS account (dataplane)

1. Install and configure the AWS CLI with your account credentials.
1. Keep in mind to configure the same AWS region where your workspace was originally deployed. The environment variables `AWS_REGION` and `AWS_DEFAULT_REGION` can be used to set the region for CLI commands.

### Optional: AWSsume

We suggest to use `AWSume` plugin to switch roles between accounts.

The following command allows to assume role based on one of your profiles configured via AWS CLI and the region can be updated based on the argument `--region`.

```bash
awsume <aws_profile> --region <aws_region>
```

## Update the list of emails for students and instructors

### Students

Update the file `config/students.yml` placing the customer emails in separate lines / items in the YAML file. Terraform will read the content and convert the variables automatically.

The Databricks users will be created automatically by Terraform after `terraform apply`.

### Instructors

Update the file `config/instructors.yml` placing the instructors emails in separate lines / items in the YAML file. Terraform will read the content and convert the variables automatically.

**IMPORTANT NOTE**: make sure the email provided is related with an existing user account in Databricks. Terraform doesn't create new users for instructors but only uses the email as reference for an internal search.

## Run Terraform

With the secrets, variables and emails configured, type the following commands in order:

```bash
source .env
terraform init
terraform plan
```

Verify the output and if everything looks right, deploy the users with command:

```bash
terraform apply -auto-approve
```