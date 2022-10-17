module "pwp-edge01" {
  source = "../"
  # Store Number/Location
  name         = "pwp-edge"
  cluster_tags = []
  node_pools = [
    {
      name          = "control_plane"
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
            name     = "test4444",
            location = "texas"
          }
        }
      ]
    },
    {
      name          = "gpu"
      control_plane = false
      labels = {
        type = "gpu"
      }
      nodes = [
        {
          uid = "6666"
          labels = {
            name = "test6666"
          }
        }
      ]
    }

  ]

  # Profiles to be added
  cluster_profiles = [
    {
      name = "opensuse-k3s"
      tag  = "1.23.0-beta1"
    }
  ]
}

