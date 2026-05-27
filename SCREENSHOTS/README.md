# Project Workflow (Step-by-Step)

## 1. Tested the application locally

- Started with the Gatus application
- Verified the application works locally before Docker or AWS
- Tested the `/health` endpoint locally
- Confirmed the app responds correctly before containerisation

Screenshot:
`01 local-docker-health-check.png`

---

## 2. Built a multi-stage Docker image

- Created a custom multi-stage Dockerfile
- First stage used for building the Go application
- Second stage used only for runtime
- Reduced image size and removed unnecessary build dependencies
- Used a non-root user for better container security

Why multi-stage build:
- Smaller image
- Faster deployment
- Reduced attack surface
- Cleaner production container

Screenshot:
`02 docker-image-build.png`

---

## 3. Ran the Docker container locally

- Built image locally using Docker
- Started the container on port 8080
- Verified container was running correctly
- Confirmed application works from inside the container

Screenshot:
`03 docker-container-running.png`

---

## 4. Pushed Docker image into Amazon ECR

- Created Amazon ECR repository
- Tagged images using SHA-style tags instead of `latest`
- Pushed container image into private ECR registry
- Used ECR as the image source for ECS

Why SHA tags:
- Immutable deployments
- Easier rollback
- Better version tracking
- Production-style image management

Screenshot:
`04 ecr-images-with-sha-tags.png`

---

## 5. Built AWS infrastructure using Terraform

- Infrastructure managed fully with Terraform
- Started by creating networking components first

Resources created:
- VPC
- Internet Gateway
- Public subnets across 2 Availability Zones
- Route tables
- Route table associations
- Security groups

Why:
- Separate networking from compute
- Production-style infrastructure layout
- Infrastructure as Code instead of manual setup

---

## 6. Created ECS cluster and deployed application

- Created ECS Fargate cluster
- Created ECS task definition
- Created ECS service
- Connected ECS service to the Application Load Balancer
- Pulled Docker image directly from ECR

Why ECS Fargate:
- Serverless containers
- No EC2 management required
- Easier scaling
- Managed runtime by AWS

Screenshot:
`05 ecs-cluster-running.png`

---

## 7. Verified ECS tasks running successfully

- Confirmed ECS tasks are healthy
- Verified containers are running correctly
- Confirmed ECS service maintains desired task count

Screenshot:
`06 ecs-task-running.png`

---

## 8. Configured Application Load Balancer (ALB)

- Created public ALB
- Added HTTP and HTTPS listeners
- Configured HTTP to HTTPS redirect
- Forwarded HTTPS traffic into ECS target group

Why ALB:
- Public entry point
- HTTPS termination
- Traffic routing
- High availability across subnets

Screenshot:
`07 alb-https-listeners.png`

---

## 9. Verified Target Group health checks

- Configured health checks against `/health`
- Confirmed ECS targets became healthy
- Verified ALB can successfully reach ECS containers

Traffic flow:
User → ALB → Target Group → ECS Tasks

Screenshot:
`08 target-group-healthcheck-success.png`

---

## 10. Configured Route53 custom domain

- Created Route53 alias record
- Pointed custom domain to ALB
- Connected DNS routing to infrastructure

Final domain:
`tm.khaled-projects.net`

Screenshot:
`09 route53-alias-record.png`

---

## 11. Configured HTTPS using ACM

- Created ACM certificate
- Validated certificate using Route53 DNS validation
- Attached ACM certificate to ALB HTTPS listener

Why ACM:
- Managed SSL certificates
- Automatic renewal
- Secure HTTPS traffic

Screenshot:
`10 AWS Certificate Manager (ACM).png`

---

## 12. Verified final live application

- Confirmed application accessible publicly
- Verified HTTPS working correctly
- Verified domain successfully routes into ECS service

Final production URL:
`https://tm.khaled-projects.net`

Screenshot:
`11-final-live-application.png`

---

## 13. Organised Terraform project structure

- Split Terraform into multiple files/modules
- Separated networking, ECS, ALB, Route53 and security resources
- Improved readability and maintainability

Why modular Terraform:
- Cleaner structure
- Easier troubleshooting
- Reusable infrastructure components
- Production-style Infrastructure as Code

Screenshot:
`12 terraform-project-structure.png`

---

## 14. Configured remote Terraform backend

- Stored Terraform state remotely in S3
- Enabled shared state management
- Prevented local-only state handling

Why remote backend:
- Safer state storage
- Better collaboration
- Persistent infrastructure state

Screenshot:
`13 terraform-s3-backend.png`

---

## 15. Automated infrastructure deployment with GitHub Actions

- Created Terraform deployment workflow
- Automated:
  - terraform fmt
  - terraform init
  - terraform validate
  - terraform plan
  - terraform apply

Why:
- Consistent deployments
- CI/CD automation
- Reduced manual deployment work

Screenshot:
`14 terraform-deploy-pipeline-success.png`

---

## 16. Automated Docker build and push pipeline

- Built Docker image automatically from GitHub Actions
- Tagged images automatically
- Pushed images into Amazon ECR
- Used GitHub Actions OIDC authentication with AWS IAM

Why OIDC:
- No static AWS credentials
- Short-lived authentication
- More secure CI/CD access

Screenshot:
`15 github-actions-docker-build-success.png`

---

## 17. Added post-deployment health check pipeline

- Created automated health check workflow
- Performed curl request against live application
- Pipeline fails automatically if application unhealthy

Why:
- Deployment verification
- Faster issue detection
- Automated production validation

Screenshot:
`17 github-actions-post-deploy-healthcheck.png`

---

# Final Architecture Flow

User  
→ Route53  
→ Application Load Balancer  
→ ECS Fargate Service  
→ ECS Tasks running Docker containers  
→ Docker image pulled from Amazon ECR

Terraform manages the infrastructure.

GitHub Actions automates:
- Docker builds
- ECR pushes
- Terraform deployments
- Health checks

HTTPS secured using ACM certificates.
