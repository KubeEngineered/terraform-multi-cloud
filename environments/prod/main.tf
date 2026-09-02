terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "ms-solutionist"
  region  = "us-central1"
}

module "prod_vpc" {
  source = "../../modules/gcp_network"

  network_name = "prod-vpc"
  subnet_name  = "prod-subnet-01"
  subnet_cidr  = "10.20.0.0/24"
  region       = "us-central1"
}

output "prod_network_id" {
  value = module.prod_vpc.network_id
}
