
resource "oci_core_instance" "ubuntu_instance" {
  # Required
  count               = 2
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.tf-compartment.id
  shape               = "VM.Standard.E2.1.Micro"

  # Optional
  display_name = "node${count.index}"
  create_vnic_details {
    subnet_id = oci_core_subnet.vcn-public-subnet.id
  }
  agent_config {
    is_management_disabled = "true"
    is_monitoring_disabled = "true"
    /* plugins_config {
      desired_state = "ENABLED"
      name          = "Management Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Custom Logs Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Bastion"
    } */
  }
  source_details {
    source_id   = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaauqipuwandlr33vnvdgyadhawcmm53ydrrugkof5h4z7erscfj5tq"
    source_type = "image"
  }
  metadata = {
    "ssh_authorized_keys" : file("/home/urbino/.oci/id_rsa.pub")
    "user_data" : filebase64("/home/urbino/oci_home/ansible_setup.sh")
  }
  preserve_boot_volume = false
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = local.tenancy_ocid
}
