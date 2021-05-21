resource "google_compute_instance" "api_server" {
  name         = "server"
  machine_type = "e2-standard-4"
  tags         = ["web"]
  metadata_startup_script = file("startup.sh")

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20210508"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public_subnetwork.name
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }
}

resource "google_compute_address" "static_ip" {
  name = "static-ip"
}

