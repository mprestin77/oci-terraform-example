// Copyright (c) 2017, 2024, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

resource "oci_identity_tag_namespace" "tag-namespace1" {
  #Required
  compartment_id = var.tenancy_ocid
  description    = var.tag_namespace["description"]
  name           = var.tag_namespace["name"]
}

resource "oci_identity_tag" "tag1" {
  #Required
  description      = "Application name"
  name             = "name"
  tag_namespace_id = oci_identity_tag_namespace.tag-namespace1.id
}

resource "oci_identity_tag" "tag2" {
  #Required
  description      = "Environment Dev|QA|Stage|Prod"
  name             = "environment"
  tag_namespace_id = oci_identity_tag_namespace.tag-namespace1.id
}
