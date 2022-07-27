[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Spectro Cloud](https://img.shields.io/badge/Developed%20by-Spectro%20Cloud-blueviolet)](https://www.spectrocloud.com)

# Palette Edge Terraform Module

The Spectro Cloud Provider for Palette is available in the [Terraform Registry](https://registry.terraform.io/providers/spectrocloud/spectrocloud/latest).  This repository contains the module and examples to create a Kubernetes Edge Cluster using Palette.  

## Assumptions

Addon profiles that will be used for the cluster creation have already been defined.  This module will reference those resources rather than create them.  Profiles can be created through the [Cluster Profile Resource](https://registry.terraform.io/providers/spectrocloud/spectrocloud/latest/docs/resources/cluster_profile)


## Usage

See the [Examples](https://github.com/spectrocloud/terraform-palette-edge/tree/main/examples) for usage of this module.

This is a sample "main.tf" file.  In this example we are creating a 3 node Ubuntu-K3s 1.21 cluster.  This cluster has a basic profile for the operating system and the k3s configuration.

It is referencing a config file located in the config directory which is defining what options we want configured for K3s.  Additionally with the "vip" tag, we enable Kubevip for HA.  The uuid referenced is the last 12 characters of the uuid.  In the case of physical hardware, the uuid is often set as the mac address of the ethernet adapter on the motherboard without ":".  Physical device in this description represents Small Form Factor appliances such as Intel NUCs and the like.

```
module "pwp-edge01" {
    source = "../../modules/edge"
    # Store Number/Location
    name = "pwp-edge"
    cluster_tags = [
        "vip:10.239.10.10"
    ]
    node_labels = {
        location = "pittsburgh"
    }
    # List of UUIDs for the devices
    edge_server = [
        {
            name = "pwp-edge-01"
            uuid = "9bbe408fb752"
            control_plane = true
        },
        {
            name = "pwp-edge-02"
            uuid = "7928a5e2544e"
            control_plane = true 
        },
        {
            name = "pwp-edge-03"
            uuid = "ca315a19fd96"
            control_plane = true
        }
    ]
    # Profiles to be added
    cluster_profiles = [
        {
            name = "edge-ubuntu-k3s"
            tag = "1.0.0"
            packs = [
                {
                    name = "prod-ubuntu-k3s"
                    tag = "1.21.12-k3s0"
                    values = file(local.value_files["k3s_config"].location)
                }
            ]
        }
    ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->