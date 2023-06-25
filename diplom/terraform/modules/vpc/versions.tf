terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.92.0"
#      version = "~> 0.61.0"
    }
  }
  required_version = ">= 1.1.0"
}
