variable "ecs_cluster_name" {
  type = string
}

variable "ecs_task_execution_role_name" {
  type = string
}

variable "ecs_task_execution_policy_arn" {
  type = string
}

variable "cloudwatch_log_group_name" {
  type = string
}

variable "cloudwatch_retention_days" {
  type = number
}

variable "ecs_task_family" {
  type = string
}

variable "ecs_cpu" {
  type = string
}

variable "ecs_memory" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "container_image_tag" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "ecs_desired_count" {
  type = number
}

variable "ecs_launch_type" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}
