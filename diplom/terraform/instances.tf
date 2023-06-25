
module "news" {
  source = "./modules/instance"
  instance_count = local.instance_count[terraform.workspace]

  subnet_id     = module.vpc.subnet_ids[0]
  zone = var.yc_region
  folder_id = module.vpc.folder_id
  image         = "centos-7"
  platform_id   = local.platforms[terraform.workspace]
  name          = local.names[terraform.workspace]
  description   = "Demo"
  instance_role = "k8s"
  users         = "centos"
  cores         = local.cores[terraform.workspace]
  boot_disk     = "network-ssd"
  disk_size     = local.disk_size[terraform.workspace]
  nat           = "true"
  memory        = "2"
  core_fraction = "100"
  depends_on = [
    module.vpc
  ]
}