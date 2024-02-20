# terraform-oci-example
## Provisioning Infrastructure on OCI Using Terraform Modules
This example shows how to use Terraform to provision the following resources:

- It creates a Virtual Cloud Network on OCI with a public and private subnets, security lists and route tables, and enables security rules

- It creates one basion VM conected to the public subnet and provisions 4 application VMs with different OS (both Linux and WIndows) based on the image ID or by looking up for the latest OCI image for the current OS. 

- It creates 2 Object Storage buckets

Once VMs are provisioned you can SSH to the bastion VM and from their ssh to application VMs 

## Prerequisites

- Permission to `manage` the following types of resources in your Oracle Cloud Infrastructure tenancy: `vcns`, `internet-gateways`, `route-tables`, `security-lists`, `subnets`, and `instances`.

- Quota to create the following resources: 1 VCN, 1 subnet, 1 Internet Gateway, 1 route rules, and 4 compute instances 

If you don't have the required permissions and quota, contact your tenancy administrator. See [Policy Reference](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm), [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm), [Compartment Quotas](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcequotas.htm).

### Clone the Repository
Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/mprestin77/terraform-oci-example
    cd terraform-oci-example
    ls

### Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Secondly, create a `terraform.tfvars` file and populate with the following information:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid        = "<compartment_ocid>"

````
You can edit variables.tf file and and set values based on your requirements

### Create the Resources
Download the latest Terraform version from https://www.terraform.io/downloads. Run the following commands:

    terraform init
    terraform plan
    terraform apply

### Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy the resources:

    terraform destroy

```

## License
Copyright (c) 2021 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.


