resource "kubernetes_deployment_v1" "go_rest" {
  depends_on = [kubernetes_deployment_v1.mysql_deployment]
  metadata {
    name = "go-rest"
    labels = {
      test = "go-rest"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "go-rest"
      }
    }

    template {
      metadata {
        labels = {
          app = "go-rest"
        }
      }

      spec {
        container {
          image = "bhatla1983/go-rest:4.0.0"
          name  = "go-rest"
          image_pull_policy = "Always"
          port {
            container_port = 8090
          }
          env {
            name = "DB_SERVER_NAME"
            value = kubernetes_service_v1.mysql_clusterip_service.metadata.0.name
          }
          env {
            name = "DB_PORT"
            value = kubernetes_service_v1.mysql_clusterip_service.spec.0.port.0.port
          }
          env {
            name = "DB_NAME"
            value_from {
              secret_key_ref {
                key = "db_name"
                name = "gorest-secret"
              }
            }
          }
          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                key = "db_user"
                name = "gorest-secret"
              }
            }
          }
          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                key = "db_password"
                name = "gorest-secret"
              }
            }
          }

        }
      }
    }
  }
}
