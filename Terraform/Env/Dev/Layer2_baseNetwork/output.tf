output "vpc" {
  value = module.vpc
}

output "private_subnets" {
  value = {
    for key, value in module.vpc :
    key => value.private_subnets
  }
}

