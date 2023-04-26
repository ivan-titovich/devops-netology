
// Создание ServiceAccount
resource "yandex_iam_service_account" "sa" {
  folder_id = var.yc_folder_id
  name      = "tf-test-sa"
}

// Наделение прав аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статических ключей доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}
