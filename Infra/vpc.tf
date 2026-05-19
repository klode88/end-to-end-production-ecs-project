module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

  public_subnet_1_cidr = var.public_subnet_1_cidr
  availability_zone_1  = var.availability_zone_1
  public_subnet_1_name = var.public_subnet_1_name

  public_subnet_2_cidr = var.public_subnet_2_cidr
  availability_zone_2  = var.availability_zone_2
  public_subnet_2_name = var.public_subnet_2_name

  igw_name = var.igw_name

  public_route_cidr       = var.public_route_cidr
  public_route_table_name = var.public_route_table_name
}


