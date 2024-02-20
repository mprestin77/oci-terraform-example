variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
}

variable "compartment_ocid" {
}

variable "ssh_public_key" {
  default = ""    # If not set it creates a new ssh key
}

variable "use_existing_vcn" {
  default = false
}

variable "vcn_id" {
  default = ""   # Set the value if you use an existing VCN
}

variable "public_subnet_id" {
  default = ""   # Set the value if you use an existing VCN
}

variable "private_subnet_id" {
  default = ""   # Set the value if you use an existing VCN
}

# Set VCN and subnet CIDR if you don't use an existing VCN
variable "network_params" {
  type = map(string)
  default = {
    vcn_cidr = "10.0.0.0/16"
    public_subnet_cidr = "10.0.100.0/24"
    private_subnet_cidr = "10.0.1.0/24"
    vcn_name  = "appvcn"
    vcn_dns_label  = "appvcn"
  }
}

variable "servers" {
    type = list(object({
        name  = string,
        shape = string,
        ocpu = string,
        memory = string,
        image_id = string,
        os = string,
        os_version = string,
        tags = list(string),
        create_in_private_subnet = bool,
        ad = number  # Number of availability domain
    }))
    default  = [
    {
         name = "bastion"
         shape = "VM.Standard.E4.Flex"
         ocpu = 1
         memory = 16
         image_id = null
         os = "Oracle Linux"
         os_version = "8"
         tags = ["App1", "Dev"]
         create_in_private_subnet = false
         ad = 1
    },
    {
         name = "appserver1"
         shape = "VM.Standard.E4.Flex"
         ocpu = 2
         memory = 32 #in GB
         boot_volume_size = 50  #in GB
         image_id = null
         os = "Oracle Linux"
         os_version = "8"      
         os = null
         os_version = null
         tags = ["App1", "Dev"]
         create_in_private_subnet = true,
         ad = 1
    },   
    {
         name = "appserver2"
         shape = "VM.Standard.E4.Flex"
         ocpu = 2 
         memory = 32 #in GB 
         boot_volume_size = 50  #in GB
         image_id = null
         os = "Canonical Ubuntu"
         os_version = "22.04"      
         tags = ["App1", "Dev"]
         create_in_private_subnet = true,
         ad = 1
    }, 
    {
         name = "appserver3"
         shape = "VM.Standard.E4.Flex"
         ocpu = 2
         memory = 32 #in GB
         boot_volume_size = 50  #in GB
         image_id = null
         os = "Windows"
         os_version = "Server 2019 Standard"
         tags = ["App1", "Dev"]
         create_in_private_subnet = true,
         ad = 1
    },
    {
         name = "appserver4"
         shape = "VM.Standard.E4.Flex"
         ocpu = 2
         memory = 32 #in GB
         boot_volume_size = 50  #in GB
         image_id = "ocid1.image.oc1.phx.aaaaaaaagspam7zo5dey5jsfv3jz6qzfqnnijnux3ygekdpqxwc7bcrzt3oq"
         os = null
         os_version = null
         tags = ["App1", "Dev"]
         create_in_private_subnet = true,
	 ad = 1
    }
   ]
} 

variable "os_buckets" {
  type     = list(object({
     name = string,
     access_type = string,
     tags = list(string)
  }))
  default  = [
    {
     name = "dev-bucket" 
     access_type = "private"
     tags = ["App1", "Dev"]
    },
    {
     name = "staging-bucket" 
     access_type = "private"
     tags = ["App1", "Stage"]
    }
  ]
}


/*
variable "image_id" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-8.8"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaelbqhmr4jgyi5lhf4rjnsxr65ivstpkp5rczvjvuq4jvhhjkpd5a"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaan76525yd23kajmkmci5cwdhmpuqz2ff6thdrf57uatig3ifc75dq"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaamjtt3zi7n432k6ry44rs7nhxfwrrpf63ahfvgzcrd5tgnwuljyfq"
    uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaah4msscolcs7qdazefqkl6i7zpmmkt5ovakis2juqp7x5lvtcqf2a"
  }
}
*/

variable "tag_namespace" {
  type = map(string)
  default = {
    name = "Application"
    description = "Application namespace"
  }
}

