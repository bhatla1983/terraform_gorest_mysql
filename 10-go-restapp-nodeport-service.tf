resource "kubernetes_service_v1" "go_rest_nodeport_service" {
  metadata {
    name = "go-rest-nodeport-service"
  }
  spec {
    type = "NodePort"
    selector = {
        app = kubernetes_deployment_v1.go_rest.spec.0.selector.0.match_labels.app
    }
    port {
      port = 80
      target_port = 8090
      node_port = 32500
    }
}

}