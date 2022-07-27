variable "edge_server" {
  description = "Values for the attributes of the edge server."
  type = list(object({
    name          = string
    uuid          = string
    control_plane = bool
  }))
}
variable "cluster_tags" {
  type        = list(string)
  description = "Tags to be added to the profile.  key:value"
  default     = []
}
variable "node_labels" {
  type        = map(string)
  description = "A map of labels to use on all nodes."
  default     = {}

}
variable "name" {
  type        = string
  description = "Name of the cluster to be created."
}
variable "cluster_profiles" {
  description = "Values for the profile(s) to be used for cluster creation."
  type = list(object({
    name = string
    tag  = optional(string)
    packs = optional(list(object({
      name   = string
      tag    = string
      values = optional(string)
      manifest = optional(list(object({
        name    = string
        tag     = string
        content = string
      })))
    })))
  }))
}