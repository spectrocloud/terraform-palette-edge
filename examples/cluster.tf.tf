module "pwp-edge01" {
  source = "../"
  # Store Number/Location
  name         = "pwp-edge"
  cluster_tags = []

  node_labels = {
    location = "pittsburgh"
  }
  # List of UUIDs for the devices
  edge_server = [
    {
      name = "pwp-edge-01"
      uuid = "9bbe408fb752"
    },
    {
      name = "pwp-edge-02"
      uuid = "7928a5e2544e"
    },
    {
      name = "pwp-edge-03"
      uuid = "ca315a19fd96"
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

