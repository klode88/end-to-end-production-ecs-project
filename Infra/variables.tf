variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2"
}

variable "availability_zone_1" {
  type        = string
  description = "First availability zone"
}

variable "availability_zone_2" {
  type        = string
  description = "Second availability zone"
}

variable "container_port" {
  type        = number
  description = "Port the container listens on"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag used by ECS"
}

variable "app_domain_name" {
  type        = string
  description = "Full domain name for the app"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route53 hosted zone ID"

}
variable "http_port" {
  type = number
}

variable "https_port" {
  type = number
}

variable "ecr_repo_name" {
  type        = string
  description = "Name of ECR repository"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of ECS cluster"
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

variable "alb_name" {
  type = string
}

variable "alb_internal" {
  type = bool
}

variable "alb_type" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  type = string
}

variable "target_group_type" {
  type = string
}

variable "health_check_path" {
  type = string
}

variable "health_check_matcher" {
  type = string
}

variable "http_listener_port" {
  type = number
}

variable "http_listener_protocol" {
  type = string
}

variable "redirect_port" {
  type = string
}

variable "redirect_protocol" {
  type = string
}

variable "redirect_status_code" {
  type = string
}


variable "route53_validation_ttl" {
  type = number
}

variable "app_record_type" {
  type = string
}

variable "evaluate_target_health" {
  type = bool
}


variable "acm_domain_name" {
  type = string
}

variable "acm_validation_method" {
  type = string
}

variable "environment" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "public_subnet_1_name" {
  type = string
}

variable "public_subnet_2_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "public_route_cidr" {
  type = string
}

variable "public_route_table_name" {
  type = string
}








