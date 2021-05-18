provider "google" {
  credentials = file("terraform-key.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {
    bucket      = "toggl-track-project-tfstate"
    prefix      = "tfstate"
    credentials = "terraform-key.json"

  }
}




