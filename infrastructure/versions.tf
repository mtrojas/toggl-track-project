terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.57"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1"
    }

  }

  required_version = "~> 0.14"
}





