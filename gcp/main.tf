resource "google_compute_instance" "instance-1" {
  boot_disk {
    auto_delete = true
    device_name = "instance-1"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230411"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    ec-src = "vm_add-tf"
    os = "linux"
    cloud = "gcp"
  }

  machine_type = "e2-micro"
  name         = "instance-1"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/practiciac/regions/us-west4/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = ""
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
  metadata = {
    "ssh-keys" =  <<EOT
        hjeong30:ssh-rsa 
EOT
  }


  zone = "us-west4-b"
}
