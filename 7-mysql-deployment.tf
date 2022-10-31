resource "kubernetes_deployment_v1" "mysql_deployment" {
  metadata {
    name = "mysql"
  }

  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }
    selector {
      match_labels = {
        app = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          image = "mysql"
          name  = "mysql"
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                key = "root_password"
                name = "mysql-secret"
              }
            }
          }
          env {
            name = "MYSQL_USER"
            value_from {
              secret_key_ref {
                key = "db_user"
                name = "mysql-secret"
              }
            }
          }
          env {
            name = "MYSQL_PASSWORD"
            value_from {
              secret_key_ref {
                key = "db_password"
                name = "mysql-secret"
              }
            }
          }
          env {
            name = "MYSQL_DATABASE"
            value_from {
              secret_key_ref {
                key = "db_name"
                name = "mysql-secret"
              }
            }
          }
          port {
            container_port = 3306
            name = "mysql"
          }
          volume_mount {
            name = "mysql-persistence-volume"
            mount_path = "/var/lib/mysql"
          }
          volume_mount {
            name = "mysql-initdb"
            mount_path = "/docker-entrypoint-initdb.d"
          }
        }
        volume {
          name = "mysql-persistence-volume"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.local_pvc.metadata.0.name
          }
        }
        volume {
          name = "mysql-initdb"
          config_map {
            name = kubernetes_config_map_v1.config_map.metadata.0.name
          }
        }
      }
    }
  }
}