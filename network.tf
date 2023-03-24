# Source from https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/
module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.5.3"
  # insert the 5 required variables here

  # Required Inputs
  compartment_id = oci_identity_compartment.tf-compartment.id
  region         = "eu-amsterdam-1"

  internet_gateway_route_rules = null
  local_peering_gateways       = null
  nat_gateway_route_rules      = null

  # Optional Inputs
  vcn_name      = "vcn-module"
  vcn_dns_label = "vcnmodule"
  vcn_cidrs     = ["10.0.0.0/16"]

  create_internet_gateway = true
  create_nat_gateway      = false
  create_service_gateway  = false
}

# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list

resource "oci_core_security_list" "public-security-list" {

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id

  # Optional
  display_name = "security-list-for-public-subnet"
  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    #Required
    protocol = "6"
    source   = var.own_public_ip
    tcp_options {
      max = 22
      min = 22
    }
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    #Required
    protocol = "all"
    source   = "10.0.0.0/16"
  }
}



# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet

resource "oci_core_subnet" "vcn-public-subnet" {

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.0.0/24"

  # Optional
  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  display_name      = "public-subnet"
  dns_label         = "cloudosos"
}

resource "oci_core_drg" "test_drg" {
  #Required
  compartment_id = oci_identity_compartment.tf-compartment.id

  #Optional
  display_name = "maindrg"
}
