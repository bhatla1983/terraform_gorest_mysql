resource "kubernetes_storage_class_v1" "local_storage" {
    metadata {
      name = "local-storage"
    }
  storage_provisioner = "kubernetes.io/noprovisioner"
  volume_binding_mode = "WaitForFirstConsumer"
}