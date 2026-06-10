# End-to-End Production ECS Project

## Project Overview

This project demonstrates how to deploy a containerised application on AWS using Docker, Terraform, ECS Fargate, GitHub Actions, HTTPS and a custom domain.

The goal was to build the infrastructure using Terraform, containerise the application with Docker and automate deployments using CI/CD pipelines.

## Architecture

<img width="43635" height="19650" alt="Blank diagram" src="https://github.com/user-attachments/assets/1b2d8fb4-0c76-4e25-a42b-c55ec34efd90" />


## Technologies Used

### AWS

- ECS Fargate
- ECR
- Application Load Balancer
- Route 53
- ACM
- CloudWatch
- IAM
- VPC

### DevOps

- Docker
- Terraform
- GitHub Actions
- Git
- Bash

## Project Flow ## System Workflow

User visits https://tm.khaled-projects.net

Route 53 points the domain to the Application Load Balancer.

The ALB handles HTTPS traffic using the ACM certificate.

The ALB forwards traffic to the ECS target group.

The ECS service runs the Docker container on Fargate.

The container image is stored in Amazon ECR.

GitHub Actions builds and pushes new Docker images, then Terraform deploys the infrastructure changes.

After deployment, a health check pipeline tests the live application endpoint.

## Infrastructure

The infrastructure was provisioned using Terraform and includes:

- VPC
- Public Subnets
- Internet Gateway
- Security Groups
- Application Load Balancer
- ECS Cluster
- ECS Service
- Route 53
- ACM Certificate

## Docker

The application was containerised using a multi-stage Docker build.

Benefits:

- Smaller image size
- Faster deployments
- Reduced attack surface

## CI/CD Pipelines

### Docker Build Pipeline

- Build Docker image
- Tag image with Git SHA
- Push image to Amazon ECR

### Terraform Deploy Pipeline

- terraform fmt
- terraform init
- terraform validate
- terraform plan
- terraform apply

### Post Deploy Health Check

- Validate application health endpoint
- Confirm deployment success

## Security

- HTTPS enabled with ACM
- Security groups restrict traffic
- OIDC authentication used by GitHub Actions
- No long-lived AWS credentials stored in GitHub

## Final Result

Application URL:

https://tm.khaled-projects.net

## What I Learned

- Docker containerisation
- Terraform Infrastructure as Code
- ECS Fargate deployments
- AWS networking
- GitHub Actions CI/CD
- OIDC authentication
- Route 53 and ACM integration

## Future Improvements

- Private subnets
- NAT Gateway
- Secrets Manager
- Auto Scaling
- Blue/Green deployments
- WAF
