terraform {
  backend "s3" {
    bucket       = "gatus-terraform-state"
    key          = "ecs-project/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}

