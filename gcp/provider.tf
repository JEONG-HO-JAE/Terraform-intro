terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("practiciac-e760fc1213f5.json")
  project = "practiciac"
  region  = "us-west4"
  zone    = "us-west4-b"
}

