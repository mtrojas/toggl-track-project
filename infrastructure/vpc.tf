// Virtual Private Cloud
resource "google_compute_network" "vpc_network" {
  name                    = "vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnetwork" {
  name          = "public-sbn"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_firewall" "fw_web" {
  project = var.project
  name    = "fw-web"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "5000"]
  }

  source_tags   = ["web"]
  target_tags   = ["web"]
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}


