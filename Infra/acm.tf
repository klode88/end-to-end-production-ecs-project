resource "aws_acm_certificate" "cert" {
  domain_name       = var.acm_domain_name
  validation_method = var.acm_validation_method

  tags = {
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "main" {
  zone_id = var.route53_zone_id
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}