module "security_groups" {
  source = "./modules/security-groups"

  vpc_id         = module.vpc.vpc_id
  http_port      = var.http_port
  https_port     = var.https_port
  container_port = var.container_port
}
