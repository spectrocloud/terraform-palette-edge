[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Spectro Cloud](https://img.shields.io/badge/Developed%20by-Spectro%20Cloud-blueviolet)](https://www.spectrocloud.com)

# Palette Edge Native Terraform Module

The Spectro Cloud Provider for Palette is available in the [Terraform Registry](https://registry.terraform.io/providers/spectrocloud/spectrocloud/latest).  This repository contains the module and examples to create a Kubernetes Edge Cluster using Palette.  

## Assumptions

Addon profiles that will be used for the cluster creation have already been defined.  This module will reference those resources rather than create them.  Profiles can be created through the [Cluster Profile Resource](https://registry.terraform.io/providers/spectrocloud/spectrocloud/latest/docs/resources/cluster_profile)


## Usage

Module Version |  Required Terraform Version
---------------|----------------------------
  <= 1.0.0     |        <= 1.2.9
  \>= 1.1.0     |        >= 1.3.0

See the [Examples](https://github.com/spectrocloud/terraform-palette-edge/tree/main/examples) for usage of this module.  This module is written for the Edge Native Deployment option.

This is a sample "main.tf" file.  In this example, we are creating a 3-node Ubuntu-K3s 1.21 cluster.  This cluster has a basic profile for the operating system and the k3s configuration.

Additionally, with the "VIP" tag, we enable Kubevip for HA.  The uid referenced is the last 12 characters of the uid.  In the case of physical hardware, the uid is often set as the mac address of the ethernet adapter on the motherboard without ":".  The physical device in this description represents Small Form Factor appliances such as Intel NUCs and the like.

```
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
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_spectrocloud"></a> [spectrocloud](#requirement\_spectrocloud) | >= 0.10.8-pre |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_spectrocloud"></a> [spectrocloud](#provider\_spectrocloud) | >= 0.10.8-pre |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [spectrocloud_appliance.this](https://registry.terraform.io/providers/spectrocloud/spectrocloud/latest/docs/resources/appliance) | resource |
| [spectrocloud_cluster_edge_native.this](https://registry.terraform.io/providers/spectrocloud/spectrocloud/latest/docs/resources/cluster_edge_native) | resource |
| [spectrocloud_cluster_profile.this](https://registry.terraform.io/providers/spectrocloud/spectrocloud/latest/docs/data-sources/cluster_profile) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_profiles"></a> [cluster\_profiles](#input\_cluster\_profiles) | Values for the profile(s) to be used for cluster creation. | <pre>list(object({<br>    name = string<br>    tag  = optional(string)<br>    packs = optional(list(object({<br>      name   = string<br>      tag    = string<br>      values = optional(string)<br>      manifest = optional(list(object({<br>        name    = string<br>        tag     = string<br>        content = string<br>      })))<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_cluster_tags"></a> [cluster\_tags](#input\_cluster\_tags) | Tags to be added to the profile.  key:value | `list(string)` | `[]` | no |
| <a name="input_cluster_vip"></a> [cluster\_vip](#input\_cluster\_vip) | IP Address for Cluster VIP for HA.  Must be unused on on the same layer 2 segment as the node IPs. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Optional - If used Latitude and Longitude represent the coordinates of the location you wish to assign to the cluster.  https://www.latlong.net/ is one tool that can be used to find this. | <pre>object({<br>    latitude  = optional(number)<br>    longitude = optional(number)<br>  })</pre> | <pre>{<br>  "latitude": 0,<br>  "longitude": 0<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster to be created. | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | Values for the attributes of the Control Plane Nodes. | <pre>list(object({<br>    name          = string<br>    labels        = optional(map(string))<br>    control_plane = bool<br>    nodes = list(object({<br>      uid    = string<br>      labels = optional(map(string))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_node_prefix"></a> [node\_prefix](#input\_node\_prefix) | n/a | `string` | `""` | no |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | n/a | `list(string)` | `[]` | no |
| <a name="input_skip_wait_for_completion"></a> [skip\_wait\_for\_completion](#input\_skip\_wait\_for\_completion) | n/a | `bool` | `true` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | n/a | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->