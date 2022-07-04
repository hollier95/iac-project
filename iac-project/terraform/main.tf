terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("./creds/serviceaccount.json")

  project = "XXXXXXX"
  region  = "XXXXXXX"
  zone    = "XXXXXXX"
}

resource "google_compute_instance" "vm_instance" {
  name         = "foo"
  machine_type = "f1-micro"
  
boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
  }
 }
  network_interface {
      network = "default"
        access_config {
        }
    }
}








