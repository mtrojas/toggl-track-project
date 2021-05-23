# Configure the GCP connection

provider "google" {
  region  = var.region
  project = var.project
}

provider "google-beta" {
  region  = var.region
  project = var.project
}

# Configure the remote backend

terraform {
  backend "gcs" {
    bucket = "toggl-track-project-tfstate"
    prefix = "tfstate"

  }
}

