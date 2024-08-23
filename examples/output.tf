### Examples for using outputs with the module.  
### For the kubeconfig and admin_kube_config you must set the skip_wait_for_completion variable to true.

#####################################################
# output "name" {
#   value = module.edge-demo-module.name
# }
# output "kubeconfig" {
#   value = module.edge-demo-module.kubeconfig
# }
# output "admin_kube_config" {
#   value = module.edge-demo-module.admin_kube_config
# }
# output "id" {
#   value = module.edge-demo-module.id
# }