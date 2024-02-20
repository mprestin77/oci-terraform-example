/*
 * This example demonstrates how to spin up compute instances and get their public and private IP.
 */

locals {
  public_subnet_id = var.use_existing_vcn ? var.public_subnet_id : oci_core_subnet.public_subnet[0].id
  private_subnet_id = var.use_existing_vcn ? var.private_subnet_id : oci_core_subnet.private_subnet[0].id
  ssh_public_key = var.ssh_public_key != "" ? var.ssh_public_key : tls_private_key.ssh_key.public_key_openssh
}

# Get the latest available image for a given OS and shape
data "oci_core_images" "ImageOCID" {
  count = length(var.servers)
  compartment_id           = var.compartment_ocid
  operating_system         = var.servers[count.index].os
  operating_system_version = var.servers[count.index].os_version
  shape                    = var.servers[count.index].shape
}

# Get availability domains
data "oci_identity_availability_domains" "ad" {
  compartment_id = var.tenancy_ocid
} 

/* Instances */

resource "oci_core_instance" "servers" {
  count = length(var.servers)
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[var.servers[count.index].ad - 1]["name"]
  compartment_id      = var.compartment_ocid
  display_name        = var.servers[count.index].name
  shape               = var.servers[count.index].shape
  shape_config {
     ocpus = var.servers[count.index].ocpu
     memory_in_gbs = var.servers[count.index].memory
  }

  source_details {
    source_id   = var.servers[count.index].image_id != null ? var.servers[count.index].image_id : data.oci_core_images.ImageOCID[count.index].images[0].id
    source_type = "image"
  }

  create_vnic_details {
    subnet_id = local.public_subnet_id
    assign_public_ip = true
    hostname_label   = var.servers[count.index].name
  }

  metadata = {
    ssh_authorized_key = local.ssh_public_key
  }

  defined_tags = {
    "Application.name" = var.servers[count.index].tags[0]
    "Application.environment" = var.servers[count.index].tags[1]
  }

  timeouts {
    create = "10m"
  }
}

output "vm_private_ip" {
  value = "${formatlist("%s: %s", oci_core_instance.servers[*].display_name, oci_core_instance.servers[*].private_ip)}"
}

output "bastion_public_ip" {
  value = oci_core_instance.servers[0].public_ip
}
