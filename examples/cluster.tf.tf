module "pwp-edge01" {
    source = "../../modules/edge"
    # Store Number/Location
    name = "pwp-edge"
    cluster_tags = [
        # "vip:10.239.10.10"
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
            control_plane = false 
        },
        {
            name = "pwp-edge-03"
            uuid = "ca315a19fd96"
            control_plane = false
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

