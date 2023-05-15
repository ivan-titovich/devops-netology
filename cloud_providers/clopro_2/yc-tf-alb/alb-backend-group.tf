resource "yandex_alb_backend_group" "alb-backend-group" {
  name      = "alb-backend-group"

  http_backend {
    name = "alb-http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_alb_target_group.alb-tg.id}"]
#    tls {
#      sni = "backend-domain.internal"
#    }
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
#    http2 = "true"
  }
}