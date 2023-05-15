resource "yandex_alb_http_router" "http-router" {
  name      = "my-http-router"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "alb-vh" {
  name           = "alb-vh"
  http_router_id = "${yandex_alb_http_router.http-router.id}"
#  authority      = "cdn.yandexcloud.example"

  route {
    name = "example-route"
    http_route {
      http_route_action {
        backend_group_id = "${yandex_alb_backend_group.alb-backend-group.id}"
      }
    }
  }
}