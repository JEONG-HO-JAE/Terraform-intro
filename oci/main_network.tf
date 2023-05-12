resource "oci_core_vcn" "vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.oci_compartment
  display_name   = "hojae-vcn"
}

resource "oci_core_route_table" "default_route_table" {
  display_name = "defaul-rt"
  vcn_id = oci_core_vcn.vcn.id
  compartment_id = var.oci_compartment

  route_rules {
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.oci_compartment
  display_name = "hojae-ig"
  vcn_id = oci_core_vcn.vcn.id
}

resource "oci_core_subnet" "public_subnet" {
  cidr_block = "10.0.0.0/24"
  display_name = "hojae-public-subnet"
  compartment_id = var.oci_compartment
  vcn_id = oci_core_vcn.vcn.id
  route_table_id = oci_core_route_table.default_route_table.id
  security_list_ids = [
		oci_core_security_list.linux_security_list.id,
		oci_core_security_list.windows_security_list.id
	]
}

