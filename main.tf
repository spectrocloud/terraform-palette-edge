data "spectrocloud_cluster_profile" "this" {
  for_each = {
    for profile in var.cluster_profiles : profile.name => profile
  }
  name    = each.key
  version = each.value["tag"]
}


resource "spectrocloud_appliance" "this" {
  for_each = { for server in var.edge_server : server.name => server }
  uid      = lower(each.value.uuid)

  labels = merge(
    { "name" = each.value.name },
    var.node_labels
  )
  wait = false
}
resource "spectrocloud_cluster_edge_native" "this" {
  name            = var.name
  tags            = var.cluster_tags
  skip_completion = var.skip_wait_for_completion
  cloud_config {
    ssh_key     = var.ssh_keys
    vip         = var.cluster_vip
    ntp_servers = var.ntp_servers
  }
  machine_pool {
    control_plane           = true
    control_plane_as_worker = true
    name                    = "master-pool"
    count                   = 1

    host_uids = values(spectrocloud_appliance.this)[*].uid
  }

  dynamic "cluster_profile" {

    for_each = var.cluster_profiles
    content {
      id = data.spectrocloud_cluster_profile.this[cluster_profile.value.name].id

      dynamic "pack" {
        for_each = cluster_profile.value.packs == null ? [] : cluster_profile.value.packs

        content {
          name   = pack.value.name
          tag    = pack.value.tag
          values = pack.value.values

          # dynamic "manifest" {
          #   for_each = pack.value.manifest== null ? [] : pack.value.manifest

          #   content {
          #   name    = manifest.value.name
          #   tag = manifest.value.tag
          #   content = manifest.value.content
          #   }
          # }
        }
      }
    }

  }
}