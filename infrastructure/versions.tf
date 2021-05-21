terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.67"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }
  }

  required_version = "~> 0.14"
}





