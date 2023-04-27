
resource "yandex_lb_network_load_balancer" "nlb-1" {
  name = "my-network-load-balancer-01"

  listener {
    name = "listener-1"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.group1.load_balancer.0.target_group_id}"

    healthcheck {
      name = "health-check-01"
      http_options {
        port = 80
        path = "/ping"
      }
    }
  }
}