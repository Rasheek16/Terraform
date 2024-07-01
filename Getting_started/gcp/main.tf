provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

data "google_compute_network" "default" {
  name = "default"
}

data "google_compute_subnetwork" "default" {
  name   = "default"
  region = "us-central1"
}

resource "google_compute_firewall" "instance" {
  name    = "terraform-example-instance"
  network = data.google_compute_network.default.id

  allow {
    protocol = "tcp"
    ports    = [var.server_port]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance_template" "example" {
  name           = "example-template"
  machine_type   = "e2-micro"
  can_ip_forward = false

  disks {
    boot         = true
    auto_delete  = true
    source_image = "debian-cloud/debian-10"
  }

  network_interfaces {
    network    = data.google_compute_network.default.id
    subnetwork = data.google_compute_subnetwork.default.id
    access_config {}
  }

  metadata_startup_script = <<-EOF
            #!/bin/bash
            echo "hello world" > /var/www/html/index.html
            nohup busybox httpd -f -p ${var.server_port} &
            EOF

  tags = ["http-server"]
}

resource "google_compute_instance_group_manager" "example" {
  name               = "example-igm"
  base_instance_name = "example-instance"
  instance_template  = google_compute_instance_template.example.id
  target_size        = 2

  named_port {
    name = "http"
    port = var.server_port
  }
}

resource "google_compute_autoscaler" "example" {
  name   = "example-autoscaler"
  zone   = "us-central1-a"
  target = google_compute_instance_group_manager.example.id

  autoscaling_policy {
    max_replicas = 10
    min_replicas = 2

    cpu_utilization {
      target = 0.6
    }
  }
}

resource "google_compute_global_address" "example" {
  name = "example-address"
}

resource "google_compute_target_http_proxy" "example" {
  name    = "example-http-proxy"
  url_map = google_compute_url_map.example.id
}

resource "google_compute_global_forwarding_rule" "example" {
  name       = "example-forwarding-rule"
  target     = google_compute_target_http_proxy.example.id
  port_range = "80"
  ip_address = google_compute_global_address.example.address
}

resource "google_compute_url_map" "example" {
  name            = "example-url-map"
  default_service = google_compute_backend_service.example.id
}

resource "google_compute_backend_service" "example" {
  name          = "example-backend-service"
  port_name     = "http"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [google_compute_health_check.example.id]

  backend {
    group = google_compute_instance_group_manager.example.instance_group
  }
}

resource "google_compute_health_check" "example" {
  name = "example-health-check"

  http_health_check {
    request_path = "/"
    port         = var.server_port
  }
}

resource "google_compute_firewall" "alb" {
  name    = "terraform-example-alb"
  network = data.google_compute_network.default.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

output "instance_group_manager" {
  value       = google_compute_instance_group_manager.example.instance_group
  description = "The instance group managed by the instance group manager"
}

output "global_forwarding_rule_ip" {
  value       = google_compute_global_forwarding_rule.example.ip_address
  description = "The IP address of the global forwarding rule"
}
