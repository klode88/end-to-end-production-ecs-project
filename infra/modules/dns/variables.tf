variable "acm_domain_name" { type = string }
variable "acm_validation_method" { type = string }
variable "environment" { type = string }
variable "route53_zone_id" { type = string }

variable "route53_validation_ttl" { type = number }
variable "app_domain_name" { type = string }
variable "app_record_type" { type = string }
variable "evaluate_target_health" { type = bool }

variable "alb_dns_name" { type = string }
variable "alb_zone_id" { type = string }
