
variable "gcp_project_id" {
  type        = string
  description = "The target GCP project id"
}




variable "gcp_region" {
  type        = string
  default     = "asia-south1"
  description = "Primary GCP region"
}



variable "machine_type" {
  type        = string
  default     = "e2-micro" # Default value when omitted in .tfvars
  description = "The VM family and size"
}



variable "environment" {
  type        = string
  description = "Target deployment environment: dev, test, stag or prod"
}



variable "resource_tags" {

  type        = map(string)
  description = "Governance labels for GCP resources"
  default = {
    bu          = "apple"
    environment = "dev"
    managed_by  = "terraform"
  }
}
