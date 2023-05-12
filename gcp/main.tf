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
    email  = "terraform@practiciac.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
  metadata = {
    "ssh-keys" =  <<EOT
        hjeong30:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCh2RLZuAbM2xitMLtj4j+P99atH+0te/qqNjnnVSxxTEL+E1lCz5SjyD7ZDiFAqjv/ColeBdOFZAeqYrnUeOoFT/wsO0lIqtAijNHsmgizUYcC+3cEWAkrCz8pHrfnymd9SB5Mp1Lffyf2HGvx4qXkcfCHCFQKPimbVX8BGSxz9DMaui7oirVW1cxPV3bSBTzNYgtrTG4KWl+fa+6qaz4tfxl+t5ftJPFGyNpuKeMmJmmcdCLDqxMC+1myfUrAXJPjBuSZtFPGx6GqTRTqOVaSlA9R2YBMEWXbZ702uPGK5D8NJ0d0gNf/P4QT9JkjyRZUysF6OuvGRV34GDRHhpXeFRtVbxuKZS6oq7IEHOIWGlRttnR1J46FryksIStEYaWaaX/bFgAw/NnkwpRM5UroaVcSbqPlGNvcZbVxSl+qAKdqtw1ZSmM9WhKEszLtBfTO9ybvZ9MjSAE8yDNSX/bP0MoBZXtPa8WRvjCBZY6hkxsd44ORLEXRRlM8jKv+Qp8= hjeong30@asu.edu
EOT
  }


  zone = "us-west4-b"
}
