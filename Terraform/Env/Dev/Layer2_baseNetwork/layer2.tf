module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  for_each        = var.vpc_configs
  name            = each.value.vpc_name
  cidr            = each.value.vpc_cidr_block
  azs             = data.aws_availability_zones.available.names
  public_subnets  = each.value.vpc_public_subnets
  private_subnets = each.value.vpc_private_subnets

  # Database Subnets
  database_subnets                   = each.value.vpc_database_subnets
  create_database_subnet_group       = each.value.vpc_create_database_subnet_group
  create_database_subnet_route_table = each.value.vpc_create_database_subnet_route_table
  # create_database_internet_gateway_route = true
  # create_database_nat_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = each.value.vpc_enable_nat_gateway
  single_nat_gateway = each.value.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true


  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags     = local.common_tags
  vpc_tags = local.common_tags

  database_subnet_tags = {
    Type = "database-subnets"
  }
  map_public_ip_on_launch = true
}


