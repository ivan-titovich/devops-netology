terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
#  backend "s3" {
#    endpoint   = "storage.yandexcloud.net"
#    bucket     = "ivan-2504"
#    region     = "ru-central1"
#    key        = "/home/lokli/devops-netology/cloud_providers/clopro_2/yc-tf-bucket/terraform.tfstate"
#    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#
#    skip_region_validation      = true
#    skip_credentials_validation = true
#  }
  required_version = ">= 0.13"
}