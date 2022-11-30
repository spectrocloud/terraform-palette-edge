module "edge-example-module" {
  source  = "spectrocloud/edge/spectrocloud"
  version = "1.1.0-pre"
  # Store Number/Location
  name = "edge-example"
  # add tags to the cluster (optional) list(strings)
  cluster_tags = []

  # Cluster VIP to be used with KubeVIP
  cluster_vip = "10.1.1.1"

  # Node Pools for Cluster
  node_pools = [
    # Control Plane Node Pool
    {
      name          = "control-plane"
      control_plane = true
      nodes = [
        {
          uid = "1234"
          labels = {
            name = "test1234"
          }
        },
        {
          uid = "3333"
          labels = {
            name = "test3333"
          }
        },
        {
          uid = "4444"
          labels = {
            name = "test4444",
          }
        }
      ]
    },
    # Add additional node pools
    {
      name          = "gpu"
      control_plane = false
      labels = {
        type = "gpu"
      }
      nodes = [
        {
          uid = "7777"
          labels = {
            name = "test7777-gpu"
          }
        }
      ]
    }

  ]

  # Profiles to be added Profile should be an Edge-Native Infra or Full Profile with the OS, Kubernetes Distribution and CNI of choice
  cluster_profiles = [
    {
      name = "ubuntu-pxke"
      tag  = "1.24.6"
    }
  ]
  # Cluster Geolocation (Optional)
  location = {
    latitude  = 33.776272
    longitude = -96.796856
  }
}

