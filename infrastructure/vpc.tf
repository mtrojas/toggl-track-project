# Create a Firewall to allow access from the Load Balancer to the instance

resource "google_compute_firewall" "firewall" {
  project = var.project
  name    = "${var.name}-fw"
  network = "default"

  # Allow load balancer access to the API instances
  # https://cloud.google.com/load-balancing/docs/https/#firewall_rules
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = ["private-app"]
  source_tags = ["private-app"]

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }
}




