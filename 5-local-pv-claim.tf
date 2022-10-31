resource "kubernetes_persistent_volume_claim_v1" "local_pvc" {
  metadata {
    name = "local-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume_v1.local_pv.metadata.0.name
    storage_class_name = kubernetes_storage_class_v1.local_storage.metadata.0.name
  }
}
