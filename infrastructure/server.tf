
# Create the instance group with a single instance and the backend service configuration

resource "google_compute_instance_group" "api" {
  project   = var.project
  name      = "${var.name}-instance-group"
  zone      = var.zone
  instances = [google_compute_instance.api.self_link]

  lifecycle {
    create_before_destroy = true
  }

  named_port {
    name = "http"
    port = 5000
  }
}

resource "google_compute_instance" "api" {
  project      = var.project
  name         = "${var.name}-instance"
  machine_type = "f1-micro"
  zone         = var.zone

  # We're tagging the instance with the tag specified in the firewall rule
  tags = ["private-app"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20210508"
    }
  }

  # Make sure we run the startup script
  metadata_startup_script = file("startup.sh")

  # Launch the instance in the default subnetwork
  network_interface {
    subnetwork = "default"

    # This gives the instance a public IP address for internet connectivity. Normally, you would have a Cloud NAT,
    # but for the sake of simplicity, we're assigning a public IP to get internet connectivity
    # to be able to run startup scripts
    access_config {
    }
  }
}

# Configure health-check for the API backend

resource "google_compute_health_check" "default" {
  project = var.project
  name    = "${var.name}-hc"

  http_health_check {
    port         = 5000
    request_path = "/api"
  }

  check_interval_sec = 5
  timeout_sec        = 5
}
