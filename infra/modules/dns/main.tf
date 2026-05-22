module "dns" {
  source = "./modules/dns"

  acm_domain_name       = var.acm_domain_name
  acm_validation_method = var.acm_validation_method
  environment           = var.environment

  route53_zone_id = var.route53_zone_id

  route53_validation_ttl = var.route53_validation_ttl

  app_domain_name        = var.app_domain_name
  app_record_type        = var.app_record_type
  evaluate_target_health = var.evaluate_target_health

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}
