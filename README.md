#  speech-to-text Infrastructure-as-Code
==============================


A Terraform configuration for deploying a speech-to-text app on IBM Container Service.

**This configuration template is tested for IBM Cloud Provider version `v0.6.0`**

Follow the instructions on the [Getting Started with IBM Cloud Schematics](https://console.ng.bluemix.net/docs/services/schematics/index.html#gettingstarted) documentation page.

|Setting	|Description|
|-------------|-----------|
|Source control URL|Enter the GitHub URL where you forked the configuration.          |
|Environment|Enter a unique name to assign to your environment.|
|Variables|You can define variables in the service or override the environment variables that are in your .tf files. You can mask sensitive variables when you click the eye icon. Masking variables prevents other users from seeing the hidden values in the environment details page. <br> Add the following variables and values to work with the  configuration:  <br>`bluemix_api_key` -  Enter your IBM Bluemix API key.


# Usage with Terraform Binary on your local workstation
You will need to [setup up IBM Cloud provider credentials](#setting-up-provider-credentials) on your local machine. 


# Prerequisite 
1) Download [Terraform binary](https://www.terraform.io/downloads.html).  Unzip it and keep the binary in path ex- /usr/local/bin.
2) Download [IBM Cloud Provider Plugin](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases). Unzip it and keep the binary in path in the same directory where you placed Terraform binary in previous step. You can also build the binary yourself. Please look into [documentation](https://github.com/IBM-Bluemix/terraform-provider-ibm/blob/master/README.md).

# To run this project locally execute the following steps:

- You can override default values that are in your variables.tf file.
  - Alternatively these values can be supplied via the command line or environment variables, see https://www.terraform.io/intro/getting-started/variables.html.
  - `terraform plan`: this will perform a dry run to show what infrastructure terraform intends to create
- `terraform apply`: this will create actual infrastructure
- `terraform destroy`: this will destroy all infrastructure which has been created

# Setting up Provider Credentials
To setup the IBM Cloud provider to work with this example there are a few options for managing credentials safely; here we'll cover the preferred method using environment variables. Other methods can be used, please see the [Terraform Getting Started Variable documentation](https://www.terraform.io/intro/getting-started/variables.html) for further details.

## Environment Variables using IBMid credentials
You'll need to export the following environment variables:

- `TF_VAR_bluemix_api_key` - your Bluemix api key
- `TF_VAR_space` - provide Bluemix space
- `TF_VAR_org` - provide Bluemix org
- `TF_VAR_private_vlan_id` - provide private vlan id
- `TF_VAR_public_vlan_id` - provide public vlan id
- `TF_VAR_subnet_id` - provide subnet id



On OS X this is achieved by entering the following into your terminal, replacing the `<value>` characters with the actual values (remove the `<>`:

- `export TF_VAR_bluemix_api_key=<value>`
- `export TF_VAR_space=<value>`
- `export TF_VAR_org=<value>`
- `export TF_VAR_private_vlan_id=<value>`
- `export TF_VAR_public_vlan_id=<value>`
- `export TF_VAR_subnet_id=<value>`


# Variables

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
|space     |Bluemix Space||
|org       |Bluemix Org||
|region   |           |eu-de|
|datacenter||ams03|
|machine_type||u2c.2x4|
|isolation||public|
|private_vlan_id|||
|public_vlan_id|||
|subnet_id|||
|service_instance_name||speech-to-text-service|
|service_key||myservicekey|
|service_offering||speech_to_text|
|plan||standard|
|cluster_name||speech-to-text|

# Output

Upon completion, terraform will output the url of the application, e.g.:

```
app_url = "<url>"

```
**Use this url to access your application**

