terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  region              = "ap-seoul-1"
  auth                = "APIKey"
}
