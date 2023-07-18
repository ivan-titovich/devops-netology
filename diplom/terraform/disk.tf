resource "yandex_compute_disk" "ddisk" {
  name       = "ddisk"
  type       = "network-hdd"
  zone       = "ru-central1-a"
  size       = 15
}