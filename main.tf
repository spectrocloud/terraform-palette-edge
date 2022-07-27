data "spectrocloud_cluster_profile" "this" {
  for_each = {
    for profile in var.cluster_profiles : profile.name => profile
  }
  name    = each.key
  version = each.value["tag"]
}

resource "spectrocloud_appliance" "this" {
  for_each = { for server in var.edge_server : server.name => server }
  uid      = lower("edge-${each.value.uuid}")

  labels = merge(
    { "cluster" = spectrocloud_cluster_import.this.id },
    { "name" = each.value.name },
    { "k8s-node-type" = each.value.control_plane == true ? "control-plane" : "worker" },
    var.node_labels
  )
  wait = false
}

resource "spectrocloud_cluster_import" "this" {
  name  = var.name
  cloud = "generic"
  tags  = var.cluster_tags

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