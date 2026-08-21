
variable "gcp_project_id" {
  type          = string
  description   = "The target GCP project id"
}




variable "region" {
  type          = string
  description   = "The region for resource deployment in GCP"
}



variable "machine_type" {
  type             = string
  default          = "e2-micro" # Default value when omitted in .tfvars
  description      = "The VM family and size"
}



variable "environment" {
  type         = string
  description  = "Target deployment environment: dev, test, stag or prod"
}



variable "resource_tag" {

  type          = map(string)
  description   = "Resource tags for cost centre allocation"
  default       = {
    bu = "apple"
 }
}

