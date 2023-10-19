
terraform {
  required_version = ">= 1.3.9"

  required_providers {
    spectrocloud = {
      version = "= 0.15.5"
      source  = "spectrocloud/spectrocloud"
    }
  }
}

provider "spectrocloud" {
  host         = var.sc_host
  api_key      = var.sc_api_key
  project_name = var.sc_project_name
}