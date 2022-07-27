locals {
  value_files = {
    k3s_config = {
      location = "./config/k3s_config.yaml"
    },
    argo_hipster_config = {
      location = "./config/argo_hipster_config.yaml"
    },
    metallb_config = {
      location = "./config/metallb_config.yaml"
    },
    linux_vm = {
      location = "./config/linux-vm.yaml"
    }
  }
}