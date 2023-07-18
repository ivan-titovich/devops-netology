locals {
  web_instance_each_map = {
    prod = {
      "kuber-master01.netology.yc" = {name="kuber-master01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8unsmfpl9uk01uodf2", size=50,  user="ubuntu"},
      "kuber-worker01.netology.yc" = {name="kuber-worker01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8unsmfpl9uk01uodf2", size=50, user="ubuntu"},
      "kuber-worker02.netology.yc" = {name="kuber-worker02", zone = "ru-central1-b", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-b.id, image_id="fd8unsmfpl9uk01uodf2", size=50, user="ubuntu"},
   }
    stage = {
      "kuber-master01.netology.yc" = {name="kuber-master01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8unsmfpl9uk01uodf2", size=50, user="ubuntu"},
      "kuber-worker01.netology.yc" = {name="kuber-worker01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8unsmfpl9uk01uodf2", size=50, user="ubuntu"},
      "kuber-worker02.netology.yc" = {name="kuber-worker02", zone = "ru-central1-b", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-b.id, image_id="fd8unsmfpl9uk01uodf2", size=50, user="ubuntu"},
    }
  }
}


# fd8unsmfpl9uk01uodf2  ubuntu 22.04 tls
# fd8sni054daiudopdnfe  centos upstream 8
