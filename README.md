# Zero to Generative AI with Databricks and AWS | Workshop Setup

> [!IMPORTANT]  
> This guide is for workshop administrators only. It contains instructions for pre-event setup of [Workshop: Zero to Generative AI with Databricks and AWS](https://catalog.workshops.aws/dare-genai-rag-databricks/en-US).

## Create a Databricks service principal with admin access

1. Access `https://accounts.cloud.databricks.com`.
1. In the left menu, open **User Management** and the tab **Service principals**.
1. Create a new service principal with name `terraform`.
1. Edit the service principal and **Generate OAuth secret**. Store the `client ID` and `client secret` for later use.
1. Ensure that the service principal has admin access to the Databricks account. To do this, go to the **Roles** tab.

## Setup AWS workshop

* Provision the workshop event and login to the workshop event's **central AWS account**.
* Go to **Cloud9** and create a new environment with the default settings. 
* Copy and paste the content in [setup.sh](./setup.sh) and run it on your terminal.
* Then, `cd ./databricks-aws-workshop-setup/`

> [!NOTE]  
> The setup script will install Terraform, clone this repository, and copy/paste that the templates for `.env` and `config/*.yml`.

## Configure Terraform credentials

1. Edit the `.env` file and configure with AWS credentials:
    1. `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN` corresponding to the AWS account above.
  
2. Then, configure `.env` with Databricks credentials:
    1. `TF_VAR_databricks_account_id` referencing the Databricks Account ID on right upper section of the Databricks console.
    2. `TF_VAR_databricks_client_id` corresponding to the `terraform` Databricks service principal above.
    3. `TF_VAR_databricks_client_secret` corresponding to the `terraform` Databricks service principal above.

2. Update the files `config/instructors.yml` and `config/students.yml` placing the emails in separate lines / items in the YAML file.

**IMPORTANT NOTE**: For `instructors.yml`, ensure that the email is related to an existing user account. (Terraform does not create new users for instructors but only uses the email as reference for an internal search).

## Run Terraform

When configured, type the following commands in order:

```bash
source .env
terraform init
terraform plan
```

Verify the output and if everything looks right, deploy the users with command:

```bash
terraform apply -auto-approve
```
