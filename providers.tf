terraform {
  required_providers {
    spectrocloud = {
      version = ">= 0.10.1"
      source  = "spectrocloud/spectrocloud"
    }
  }
  experiments = [module_variable_optional_attrs]
}