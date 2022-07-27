terraform {
  required_providers {
    spectrocloud = {
      version = ">= 0.8.3"
      source  = "spectrocloud/spectrocloud"
    }
  }
  experiments = [module_variable_optional_attrs]
}