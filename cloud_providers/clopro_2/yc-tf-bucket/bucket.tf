
// Создание бакета с помощью ключей
resource "yandex_storage_bucket" "ivan-2504" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "ivan-2504"
  default_storage_class = "STANDARD"
  acl           = "public-read"
  force_destroy = "true"

  anonymous_access_flags {
    read = true
    list = true
    config_read = true
  }
}

// Загрузка картинки в созданный бакет.
resource "yandex_storage_object" "chatgpt-robot" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "ivan-2504"
  key    = "chatgpt-robot"
  source = "../src/chatgpt-robot.jpg"
  depends_on = [
    yandex_storage_bucket.ivan-2504,
  ]
}