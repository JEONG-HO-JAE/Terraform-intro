resource "oci_core_instance" "winodws_instance" {
    availability_domain = var.instance_availability_domain
    compartment_id = var.oci_compartment
    shape = var.shape

    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.public_subnet.id
    }

    metadata = {
        ssh_authorized_keys = file("/home/centos/.ssh/terraform_key/id_rsa.pub")
    }

    freeform_tags = {"os"= "Windows", "cloud"="oci"}

    source_details {
        #Required
        source_id = var.window_source_id
        source_type = "image"
    }
    shape_config {

        #Optional
        memory_in_gbs = "16"
        ocpus = "1"
    }
}

