resource "kubernetes_config_map_v1" "config_map" {
  metadata {
    name = "mysql-dbcreation-script"
  }

  data = {
    "init.sql" = "${file("${path.module}/init.sql")}"
  }
}