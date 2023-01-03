terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.47.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = ">= 3.67.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
  credentials = var.path
}
provider "google-beta" {
  project = var.project_id
  credentials = var.path
}


