output "vpc_id" {
  description = "ID of the main VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  description = "ID of the first public subnet"
  value       = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  description = "ID of the second public subnet"
  value       = module.vpc.public_subnet_2_id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.gatus.dns_name
}

output "app_url" {
  description = "Public HTTPS URL for the application"
  value       = "https://tm.khaled-projects.net"
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.gatus.repository_url
}