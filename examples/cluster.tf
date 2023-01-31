module "edge-demo-module" {
  # source  = "spectrocloud/edge/spectrocloud"
  # version = "1.1.0"
  source = "../"
  # Store Number/Location
  name = "demo"
  # add tags to the cluster (optional) list(strings)
  cluster_tags = ["origin:terraform"]

  # Cluster VIP to be used with KubeVIP
  cluster_vip = "192.168.1.250"

  # Node Pools for Cluster
  node_pools = [
    # Control Plane Node Pool
    {
      name          = "control-plane"
      control_plane = true
      # Edge Host Labels used to find the Edge Host via tags
      edge_host_tags = {
        # "store" : "903",
        "uid" : "12345"
        "type" : "control_plane"
      }
      pool_labels = {
        "region" : "east"
      }
    },
    # Add additional node pools
    # {
    #   name          = "gpu"
    #   control_plane = false
    #   edge_host_tags = {
    #     "store" : "903",
    #     "type" : "gpu"
    #   }
    #   pool_labels = {
    #     "type" : "gpu",
    #     "region" : "east"
    #   }
    # }
  ]

  # Profiles to be added Profile should be an Edge-Native Infra or Full Profile with the OS, Kubernetes Distribution and CNI of choice
  cluster_profiles = [
    {
      name    = "ubuntu-k3s"
      tag     = "1.24.6"
      context = "tenant"
    },
    {
      name    = "core-edge-services"
      tag     = "1.0.0"
      context = "project"
    },
    {
      name    = "kubevirt"
      tag     = "1.0.0"
      context = "project"
    },
  ]
  # Cluster Geolocation (Optional)
  location = {
    latitude  = 40.442829
    longitude = -79.950432
  }
}
