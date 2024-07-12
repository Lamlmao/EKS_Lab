module "s3_tfstate" {
  source            = "../../../Modules/Backend_State"
  for_each          = var.backend_configs
  Environment       = each.value.environment
  Application       = each.value.application
  resource_uid      = each.value.resource_uid
  name              = each.value.name
  hash_key          = each.value.hash_key
  attribute_name    = each.value.attribute_name
  type              = each.value.type
  bucket_versioning = each.value.bucket_versioning
}

module "route53" {
  source                     = "../../../Modules/Route53"
  for_each                   = var.route53_configs
  Environment                = each.value.environment
  Application                = each.value.application
  create_route53_hosted_zone = each.value.create_route53_hosted_zone
  domain_name                = each.value.domain_name
}
