variable "edge_server" {
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
  description = "A map of labels to use on all nodes"
  default     = {}

}
variable "name" {
  type = string
}
variable "cluster_profiles" {
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