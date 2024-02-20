// Copyright (c) 2017, 2024, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

/*
 * This example shows how to manage a bucket
 */

data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_ocid
}

resource "oci_objectstorage_bucket" "os_buckets" {
  count = length(var.os_buckets)
  compartment_id = var.compartment_ocid
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = var.os_buckets[count.index].name
  access_type    = "NoPublicAccess"
  auto_tiering = "Disabled"
  defined_tags = {
    "Application.name" = var.os_buckets[count.index].tags[0]
    "Application.environment" = var.os_buckets[count.index].tags[1]
  }
}

