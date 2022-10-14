variable "edge_server" {
  description = "Values for the attributes of the Control Plane Nodes."
  type = list(object({
    name = string
    uuid = string
  }))
}
variable "node_prefix" {
  type    = string
  default = ""
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
variable "cluster_vip" {
  type    = string
  default = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.cluster_vip, 32))
    error_message = "Must be valid IPv4 CIDR."
  }
}
variable "ssh_keys" {
  type    = string
  default = ""
}
variable "ntp_servers" {
  type    = list(string)
  default = []
}
variable "skip_wait_for_completion" {
  type    = bool
  default = true
}