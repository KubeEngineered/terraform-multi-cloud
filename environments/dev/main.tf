terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "ms-solutionist-tfstate-dev"
    prefix = "terraform/state/dev"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}



provider "google" {
  project = var.project_id
  region  = var.region
}




module "dev_network" {
  source             = "../../modules/gcp_network"
  project_id         = var.project_id
  region             = var.region
  network_name       = "dev-vpc"
  subnet_cidr        = "10.10.1.0/24"
}



module "dev_vm" {
  source        = "../../modules/gcp_compute"
  project_id    = var.project_id
  zone          = "us-central1-a"
  instance_name = "dev-app-server"
  machine_type  = "e2-micro"
  subnet_id     = module.dev_network.subnet_id
}
