resource "oci_core_security_list" "linux_security_list" {
  compartment_id = var.oci_compartment
  vcn_id = oci_core_vcn.vcn.id
  display_name = "hojae-linux-sl"

  egress_security_rules {
     protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }
}

