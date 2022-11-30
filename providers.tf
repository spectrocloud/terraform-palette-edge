terraform {
  required_providers {
    spectrocloud = {
      version = ">= 0.10.8-pre"
      source  = "spectrocloud/spectrocloud"
    }
  }
  required_version = ">= 1.3.0"
}