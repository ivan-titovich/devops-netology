resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_network" "network-2" {
  name = "network2"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "public"
  zone           = var.yc_region
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "private"
  zone           = var.yc_region
  network_id     = yandex_vpc_network.network-2.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}



resource "yandex_compute_instance" "nat-instance-1" {
  name = "nat-instance-1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
    ip_address = "192.168.10.254"
  }

}

resource "yandex_vpc_route_table" "lab-rt-1" {
  network_id = "${yandex_vpc_network.network-2.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
#    gateway_id         = "${yandex_compute_instance.nat-instance-1.id}"
    next_hop_address = "192.168.10.254"
  }
}

resource "yandex_compute_instance" "vm-1" {
  name = "vm-1"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8evlqsgg4e81rbdkn7"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "vm-2"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8evlqsgg4e81rbdkn7"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
