module "ecs" {
  source = "./modules/ecs"

  ecs_cluster_name              = var.ecs_cluster_name
  ecs_task_execution_role_name  = var.ecs_task_execution_role_name
  ecs_task_execution_policy_arn = var.ecs_task_execution_policy_arn

  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  cloudwatch_retention_days = var.cloudwatch_retention_days

  ecs_task_family = var.ecs_task_family
  ecs_cpu         = var.ecs_cpu
  ecs_memory      = var.ecs_memory

  container_name      = var.container_name
  container_port      = var.container_port
  container_image_tag = var.container_image_tag
  aws_region          = var.aws_region

  ecs_service_name  = var.ecs_service_name
  ecs_desired_count = var.ecs_desired_count
  ecs_launch_type   = var.ecs_launch_type

  ecr_repository_url    = module.ecr.repository_url
  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_security_group_id = module.security_groups.ecs_sg_id
  target_group_arn      = module.alb.target_group_arn

  depends_on = [module.alb]
}
