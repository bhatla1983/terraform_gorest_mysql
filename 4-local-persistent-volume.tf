resource "kubernetes_persistent_volume_v1" "local_pv" {
  metadata {
    name = "local-pv"
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name = kubernetes_storage_class_v1.local_storage.metadata.0.name
    persistent_volume_source {
      local {
        path = "/Users/ankurbhatla/mount-tf"
      }
    }
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "kubernetes.io/hostname"
            operator = "In"
            values = [ "docker-desktop" ]
          }
        }
      }
    }
  }
}