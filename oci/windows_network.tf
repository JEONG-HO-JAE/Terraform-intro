resource "oci_core_security_list" "windows_security_list" {
  compartment_id = var.oci_compartment
  vcn_id = oci_core_vcn.vcn.id
  display_name = "hojae-winodws-sl"

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
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
        min = 3389
        max = 3389
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
        min = 5985
        max = 5985
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
        min = 5986
        max = 5986
    }
  }

}


