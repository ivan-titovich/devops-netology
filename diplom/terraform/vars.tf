variable "yc_token" {
   default = ""
}

variable "yc_cloud_id" {
  default = ""
}

variable "yc_folder_id" {
  default = ""
}

variable "yc_region" {
  default = ""
}

variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}



locals {
  names = {
    default = "stage"
    stage = "stage"
    prod = "prod"
  }
  cores = {
    default = 2
    stage = 2
    prod = 2
  }
  platforms = {
    default = "standard-v1"
    stage = "standard-v1"
    prod = "standard-v2"
  }
  disk_size = {
    default = 20
    stage = 20
    prod = 40
  }
  instance_count = {
    default = 1
    stage = 1
    prod = 5
  }

  vpc_subnets = {
    default = [
      {
        "v4_cidr_blocks": [
          "10.128.0.0/24"
        ],
        "zone": var.yc_region
      }
    ]
    stage = [
      {
        "v4_cidr_blocks": [
          "10.128.0.0/24"
        ],
        "zone": var.yc_region
      }
    ]
    prod = [
      {
        zone           = "ru-central1-a"
        v4_cidr_blocks = ["10.128.0.0/24"]
      },
      {
        zone           = "ru-central1-b"
        v4_cidr_blocks = ["10.129.0.0/24"]
      },
      {
        zone           = "ru-central1-c"
        v4_cidr_blocks = ["10.130.0.0/24"]
      }
    ]
  }
}

