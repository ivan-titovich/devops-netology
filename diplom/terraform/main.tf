terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "dip-bucket"
    region     = "ru-central1"
    key        = "terraform/terraform.tfstate"
    access_key = "YCAJEQmNM7TvjbXFpr1Js5bcI"
    secret_key = "YCM-PafUcXY3HtsvBLFyHKyXtYRy29dtTmVI3OXh"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

#_____СОЗДАНИЕ СА______
#resource "yandex_iam_service_account" "sa" {
#  name = "tf-sa-d-1"
#}
#// Назначение роли сервисному аккаунту
#resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
#  folder_id = var.yc_folder_id
#  role      = "storage.editor"
#  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
#}
#
#resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
# service_account_id = yandex_iam_service_account.sa.id
# description        = "Service account for diplom project bucket"
## pgp_key            = "keybase:keybaseusername"
# }
#___end__СОЗДАНИЕ СА______

##___CREATE_BUCKET_____
#resource "yandex_storage_bucket" "dip-bucket" {
#  access_key = "YCAJEQmNM7TvjbXFpr1Js5bcI"
#  secret_key = "YCM-PafUcXY3HtsvBLFyHKyXtYRy29dtTmVI3OXh"
#  bucket     = "dip-bucket"
#}
##_end__CREATE_BUCKET_____