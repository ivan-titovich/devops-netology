resource "yandex_compute_image" "foo-image" {
  name       = "netology-test-image"
  source_url = "https://storage.yandexcloud.net/lucky-images/kube-it.img"
}

resource "yandex_compute_instance" "vm" {
  name = "vm-from-netology-test-image"

  resources {
    cores  = 2
    memory = 4
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.foo.id}"
  }

  boot_disk {
    initialize_params {
      image_id = "${yandex_compute_image.foo-image.id}"
    }
  }
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone       = var.yc_region
  network_id = "${yandex_vpc_network.foo.id}"
  v4_cidr_blocks = ["10.128.0.0/24"]
}