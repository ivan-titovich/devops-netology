resource "yandex_alb_load_balancer" "application-balancer" {
  name        = "application-load-balancer"

  network_id  = yandex_vpc_network.network-1.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }
  }

  listener {
    name = "alb-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.http-router.id
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["2XX"]
      discard_percent = 75
    }
  }
}