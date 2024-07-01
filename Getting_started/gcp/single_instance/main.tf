provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

resource "google_compute_instance" "example" {
  name         = "my-first-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
            #!/bin/bash
            echo "hello world" > /var/www/html/index.html
            nohup busybox httpd -f -p 8080 &
            EOF

  tags = ["http-server"]
}

resource "google_compute_firewall" "default" {
  name    = "terraform-example-instance"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["http-server"]
}
