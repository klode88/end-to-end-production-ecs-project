resource "aws_ecr_repository" "gatus" {
  name = var.ecr_repo_name
}

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name

  tags = {
    name = var.ecs_cluster_name
  }
}