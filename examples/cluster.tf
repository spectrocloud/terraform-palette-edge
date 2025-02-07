module "edge-demo-module" {
  source  = "spectrocloud/edge/spectrocloud"
  version = "1.5.0"
  # Store Number/Location
  name = "demo"
  # add tags to the cluster (optional) list(strings)
  cluster_tags = ["origin:terraform"]
  ssh_keys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbm test2",
  "ecdsa-sha2-nistp256 AAAAE2VjZHNhL test1"]
  ntp_servers = [
    "10.10.10.1",
    "10.10.10.2"
  ]

  # Cluster VIP to be used with KubeVIP If not using Overlay
  # cluster_vip = "10.10.100.5"

  # Overlay CIDR Range
  overlay_cidr_range = "100.64.128.0/18"

  # Node Pools for Cluster
  machine_pools = [
    # Control Plane Node Pool
    {
      name                    = "control-plane"
      control_plane           = true
      control_plane_as_worker = false
      additional_labels = {
        "region" : "east"
      }
      edge_host = [
        {
          host_uid        = "edge12345"
          host_name       = "edge1"
          static_ip       = "10.100.100.31"
          subnet_mask     = "255.255.255.0"
          default_gateway = "10.100.100.1"
          dns_servers     = ["10.100.100.1", "10.100.100.2"]

        },
        {
          host_uid        = "edge123456"
          host_name       = "edge2"
          static_ip       = "10.100.100.32"
          subnet_mask     = "255.255.255.0"
          default_gateway = "10.100.100.1"
          dns_servers     = ["10.100.100.1", "10.100.100.2"]
          nic_name        = "auto"

        }
      ]
    },
    # Add additional node pools
    {
      name          = "gpu"
      control_plane = false
      edge_host = [

        {
          host_uid  = "123test"
          static_ip = "2.2.2.2"
        }
      ]
      additional_labels = {
        "type" : "gpu",
        "region" : "east"
      }
    }

  ]

  # Profiles to be added Profile should be an Edge-Native Infra or Full Profile with the OS, Kubernetes Distribution and CNI of choice
  cluster_profiles = [
    {
      name    = "edge-profile"
      tag     = "1.30.5-ubuntu"
      context = "project"
    },
    {
      name    = "edge-services"
      tag     = "1.0.0"
      context = "project"
    },
    {
      name    = "edge-logging"
      tag     = "1.0.0"
      context = "project"
    }
  ]
  # Cluster Geolocation (Optional)
  location = {
    latitude  = 40.442829
    longitude = -79.950432
  }
  rbac_bindings = [
    {
      rbac_type = "ClusterRoleBinding"
      rbac_role = {
        name = "cluster-admin"
        kind = "ClusterRole"
      }
      subjects = [
        {
          name      = "k8s-admin"
          rbac_type = "Group"
        }
      ]
    }
  ]

}
