resource "yandex_compute_instance_group" "ig-1" {
  name                = "ig-with-balancer"
  folder_id           = var.yc_folder_id
  service_account_id  = "${yandex_iam_service_account.sa.id}"
#  deletion_protection = true
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.network-1.id}"
      subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
      nat        = true
    }
#    labels = {
#      label1 = "label1-value"
#      label2 = "label2-value"
#    }
    metadata = {
#      foo      = "bar"
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = "${file("../src/index.yaml")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

#  variables = {
#    test_key1 = "test_value1"
#    test_key2 = "test_value2"
#  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
#    max_creating    = 3
    max_expansion   = 0
    max_deleting    = 2
  }

  application_load_balancer {
    target_group_name = "alb-tg"
    target_group_description = "application load balancer target group"
  }

  health_check {
    interval = 30
    timeout = 10
    unhealthy_threshold = 5
    healthy_threshold = 3
    http_options{
      port = 80
      path ="/"
    }
  }
}