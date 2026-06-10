module "vpc" {
  source = "./infra/modules/vpc"

  vpc_cidr                = var.vpc_cidr
  public_subnet_1_cidr    = var.public_subnet_1_cidr
  public_subnet_2_cidr    = var.public_subnet_2_cidr
  availability_zone_1     = var.availability_zone_1
  availability_zone_2     = var.availability_zone_2
  vpc_name                = var.vpc_name
  public_subnet_1_name    = var.public_subnet_1_name
  public_subnet_2_name    = var.public_subnet_2_name
  igw_name                = var.igw_name
  public_route_cidr       = var.public_route_cidr
  public_route_table_name = var.public_route_table_name
}

module "security_groups" {
  source = "./infra/modules/security-groups"

  vpc_id         = module.vpc.vpc_id
  http_port      = var.http_port
  https_port     = var.https_port
  container_port = var.container_port
}

module "ecr" {
  source = "./infra/modules/ecr"

  ecr_repo_name = var.ecr_repo_name
}

module "dns" {
  source = "./infra/modules/dns"

  acm_domain_name        = var.acm_domain_name
  acm_validation_method  = var.acm_validation_method
  environment            = var.environment
  route53_zone_id        = var.route53_zone_id
  route53_validation_ttl = var.route53_validation_ttl

  app_domain_name        = var.app_domain_name
  app_record_type        = var.app_record_type
  evaluate_target_health = var.evaluate_target_health

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "alb" {
  source = "./infra/modules/alb"

  alb_name              = var.alb_name
  alb_internal          = var.alb_internal
  alb_type              = var.alb_type
  alb_security_group_id = module.security_groups.alb_sg_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  vpc_id                = module.vpc.vpc_id

  target_group_name     = var.target_group_name
  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol
  target_group_type     = var.target_group_type
  health_check_path     = var.health_check_path
  health_check_matcher  = var.health_check_matcher

  http_listener_port     = var.http_listener_port
  http_listener_protocol = var.http_listener_protocol
  redirect_port          = var.redirect_port
  redirect_protocol      = var.redirect_protocol
  redirect_status_code   = var.redirect_status_code

  certificate_arn = module.dns.certificate_arn
}

module "ecs" {
  source = "./infra/modules/ecs"

  ecs_cluster_name              = var.ecs_cluster_name
  ecs_task_execution_role_name  = var.ecs_task_execution_role_name
  ecs_task_execution_policy_arn = var.ecs_task_execution_policy_arn

  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  cloudwatch_retention_days = var.cloudwatch_retention_days

  ecs_task_family     = var.ecs_task_family
  ecs_cpu             = var.ecs_cpu
  ecs_memory          = var.ecs_memory
  container_name      = var.container_name
  container_port      = var.container_port
  container_image_tag = var.container_image_tag
  aws_region          = var.aws_region

  ecs_service_name  = var.ecs_service_name
  ecs_desired_count = var.ecs_desired_count
  ecs_launch_type   = var.ecs_launch_type

  ecr_repository_url = module.ecr.repository_url
  public_subnet_ids  = module.vpc.public_subnet_ids
  ecs_sg_id          = module.security_groups.ecs_sg_id
  target_group_arn   = module.alb.target_group_arn
}
