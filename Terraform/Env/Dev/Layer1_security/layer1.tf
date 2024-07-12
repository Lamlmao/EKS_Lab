module "ACM" {
  source            = "../../../Modules/ACM"
  for_each          = var.acm_configs
  Application       = each.value.application
  Environment       = each.value.environment
  domain_name       = each.value.domain_name
  validation_method = each.value.validation_method
}

