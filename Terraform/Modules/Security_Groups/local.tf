locals {
  tags = {
    Environment = "${var.Environment}"
    Application = "${var.Application}"
  }
  # cluster_security_group_id = one(aws_eks_cluster.default[*].vpc_config[0].cluster_security_group_id)
  managed_security_group_rules_enabled = var.enabled && var.managed_security_group_rules_enabled
}
