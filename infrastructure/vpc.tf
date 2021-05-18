// Virtual Private Cloud
resource "google_compute_network" "vpc_network" {
  name                    = "vpc"
  auto_create_subnetworks = false
}

//firewall
// internet gateway?

resource "google_compute_subnetwork" "public_subnetwork" {
  name          = "public-sbn"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_firewall" "fw_web" {
  name = "fw-web"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_tags = [ "web" ]
  source_ranges = [ "0.0.0.0/0" ]
}

//https://registry.terraform.io/modules/gruntwork-io/network/google/latest/submodules/vpc-network
# module "network_vpc-network" {
#   source  = "gruntwork-io/network/google//modules/vpc-network"
#   version = "0.8.1"
#   # insert the 5 required variables here
#   project     = var.project
#   name_prefix = var.name_prefix
#   region      = var.region
# }
