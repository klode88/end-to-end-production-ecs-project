````markdown
# End-to-End Production ECS Project

## Project Overview

This project was built to simulate a real production-style deployment workflow on AWS using modern DevOps practices.

The goal was to understand the full lifecycle of deploying a containerised application into AWS using:

- Docker
- Terraform
- ECS Fargate
- GitHub Actions
- HTTPS and custom domains
- CI/CD automation

Instead of creating infrastructure manually in AWS Console first, the project was built directly using Infrastructure as Code with Terraform from the beginning.

This is why the repository is called an **End-to-End Production ECS Project**.

The project connects all layers together into one complete workflow:

```text
Application
→ Docker
→ ECR
→ Terraform Infrastructure
→ ECS Fargate
→ HTTPS + Domain
→ CI/CD Pipelines
→ Automated Health Checks
````

---

# Technologies Used

## AWS Services

* Amazon ECS Fargate
* Amazon ECR
* Application Load Balancer (ALB)
* Amazon Route 53
* AWS Certificate Manager (ACM)
* Amazon CloudWatch
* IAM
* VPC
* Public Subnets
* Internet Gateway
* Security Groups

## DevOps Tools

* Docker
* Terraform
* GitHub Actions
* Git
* Bash scripting

---

# Project Structure

```text
.
├── app/
├── infra/
│   ├── modules/
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   └── terraform.tfvars
│
├── .github/
│   └── workflows/
│       ├── docker-build-push.yml
│       ├── terraform-deploy.yml
│       └── post-deploy-check.yml
│
├── Dockerfile
├── .dockerignore
├── .gitignore
└── README.md
```

---

# Step 1 — Application Setup

The project started with a lightweight monitoring application called **Gatus**.

The application was cloned locally using Git.

The reason for cloning and testing the application first was to ensure the application itself worked correctly before introducing Docker or AWS infrastructure.

The application exposes a simple health endpoint:

```bash
curl http://localhost:8080/health
```

Expected output:

```json
{"status":"ok"}
```

This endpoint is later used for:

* ECS health checks
* ALB target health checks
* CI/CD deployment validation

---

# Step 2 — Local Docker Testing

After confirming the application worked locally, Docker was introduced.

The goal of Docker was to package:

* the application
* dependencies
* runtime
* configuration

into a single portable container image.

This ensures the same application runs consistently:

* locally
* inside ECS
* inside CI/CD pipelines
* across environments

without dependency or environment issues.

The container was tested locally before deploying anything to AWS.

---

# Step 3 — Multi-Stage Docker Build

A multi-stage Dockerfile was created.

## Builder Stage

The first stage:

* downloads dependencies
* compiles the Go application
* builds the binary

## Runtime Stage

The second stage:

* contains only the final application binary
* removes unnecessary build tools
* creates a smaller production image

---

# Why Multi-Stage Builds Were Used

Using multi-stage builds improves:

* image size
* security
* deployment speed

because unnecessary build dependencies are not included in the final image.

## Result

* Smaller image
* Faster deployments
* Reduced attack surface
* Cleaner runtime container

---

# Step 4 — Terraform Setup

After Docker testing, Terraform was introduced to build the AWS infrastructure.

Instead of creating resources manually in AWS Console, the infrastructure was built directly using Infrastructure as Code.

Terraform was used because manual infrastructure becomes:

* difficult to maintain
* inconsistent
* hard to reproduce
* difficult to scale

Infrastructure as Code solves this by making infrastructure:

* repeatable
* version controlled
* automated
* easier to maintain

---

# Step 5 — Networking Infrastructure

The first AWS resources built with Terraform were the networking components.

The networking layer included:

* VPC
* Internet Gateway
* Public subnets
* Route tables
* Route table associations
* Security groups

---

# Networking Design

## VPC

The VPC acts as the main AWS network.

## Public Subnets

Two public subnets were created across two Availability Zones for high availability.

## Internet Gateway

The Internet Gateway connects the VPC to the public internet.

## Route Tables

Route tables send subnet traffic to the Internet Gateway.

## Security Groups

Security groups control traffic between AWS resources.

---

# Traffic Flow

```text
User
 ↓
Internet
 ↓
Internet Gateway
 ↓
Public Subnets
 ↓
Application Load Balancer
 ↓
Target Group
 ↓
ECS Fargate Service
 ↓
Docker Container
```

---

# Security Design

Only the Application Load Balancer is publicly exposed.

The ECS service itself stays protected behind the ALB.

The ECS security group only accepts traffic from the ALB security group.

This prevents direct public access to the containers.

---

# Step 6 — Amazon ECR

After the Docker image was built locally, Amazon ECR (Elastic Container Registry) was created.

ECR acts as the private Docker image registry used by ECS.

The Docker image was pushed into ECR using GitHub Actions.

Images were tagged using Git commit SHAs instead of `latest`.

Example:

```text
gatus:bc433161
```

Using SHA tags improves:

* traceability
* rollback capability
* deployment consistency

because ECS always knows exactly which image version is deployed.

---

# Step 7 — ECS Fargate Deployment

After networking and ECR were ready, ECS infrastructure was built using Terraform.

The ECS deployment included:

* ECS Cluster
* ECS Task Definition
* ECS Service
* CloudWatch Logs
* IAM roles and policies

Amazon ECS Fargate was chosen because it allows containers to run without managing EC2 servers manually.

Instead of managing virtual machines:

* AWS manages the infrastructure
* ECS manages orchestration
* Fargate runs the containers

This allows focus on the application instead of server maintenance.

---

# Step 8 — Application Load Balancer and HTTPS

The application was exposed publicly using:

* Application Load Balancer
* Route 53
* ACM Certificate

HTTPS was configured using AWS Certificate Manager.

HTTP traffic is redirected to HTTPS for secure communication.

## Final Application URL

```text
https://tm.khaled-projects.net
```

---

# Step 9 — CI/CD Automation

After the infrastructure was working, GitHub Actions pipelines were introduced.

The goal was to automate:

* Docker image builds
* Image pushes
* Terraform validation
* Infrastructure deployment
* Deployment verification

---

# CI/CD Pipelines

## Pipeline 1 — Docker Build and Push

This workflow:

* builds the Docker image
* tags the image using the Git commit SHA
* authenticates into AWS ECR
* pushes the image into ECR

OIDC authentication was used instead of static AWS access keys.

---

## Pipeline 2 — Terraform Deploy

This workflow automates Terraform deployment.

The pipeline runs:

```text
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
```

This allows infrastructure changes to be deployed directly from GitHub Actions.

---

## Pipeline 3 — Post Deploy Health Check

After deployment, a health-check pipeline verifies the application is reachable.

The workflow runs:

```bash
curl https://tm.khaled-projects.net/health
```

If the endpoint fails, the pipeline fails.

This simulates real production deployment validation.

---

# OIDC Authentication

GitHub Actions authenticates into AWS using OIDC.

This avoids storing permanent AWS access keys inside GitHub.

## Benefits

* Short-lived credentials
* Improved security
* No static AWS secrets
* Better IAM control
* Production-style authentication

---

# CloudWatch Logging

CloudWatch Logs were configured for ECS tasks.

This allows:

* application monitoring
* troubleshooting
* deployment debugging
* container visibility

---

# Bash Scripting Improvements

Simple Terraform aliases were created using Bash scripting:

```bash
tf
tfp
tfa
```

This helped speed up the Terraform workflow during development.

---

# What This Project Demonstrates

This project demonstrates understanding of:

* Docker containerisation
* ECS Fargate deployments
* AWS networking
* Terraform Infrastructure as Code
* Application Load Balancers
* HTTPS and ACM
* Route 53 DNS
* GitHub Actions CI/CD
* OIDC authentication
* CloudWatch logging
* Deployment validation
* Real-world troubleshooting

---

# Why This Is an End-to-End Project

This project is called an end-to-end deployment because it covers the complete deployment lifecycle:

```text
Application
→ Docker
→ ECR
→ Terraform Infrastructure
→ ECS Fargate
→ HTTPS + Domain
→ CI/CD Pipelines
→ Automated Health Checks
```

Instead of focusing on one individual technology, the project connects all layers together into one complete production-style workflow.

---

# Future Improvements

Possible future improvements include:

* Private subnets for ECS tasks
* NAT Gateway architecture
* Secrets Manager or Parameter Store
* Blue/Green deployments
* ECS Auto Scaling
* WAF integration
* Monitoring dashboards
* Slack notifications
* Terraform destroy pipeline
* GitHub Actions approvals and environments

```
```
