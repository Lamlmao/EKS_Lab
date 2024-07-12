module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "19.15.1"
  for_each                       = var.eks_configs
  cluster_name                   = each.value.cluster_name
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = data.terraform_remote_state.vpc_data.outputs.vpc[each.value.vpc_name].vpc_id
  subnet_ids = data.terraform_remote_state.private_subnets_data.outputs.private_subnets[each.value.vpc_name]

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController,
  ]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type                              = each.value.ami_type
    instance_types                        = each.value.instance_types
    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    amc-cluster-wg = {
      min_size       = each.value.min_size
      max_size       = each.value.max_size
      desired_size   = each.value.desired_size
      instance_types = each.value.instance_types
      capacity_type  = each.value.capacity_type
      depends_on = [
        aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
      ]
    }
  }
  tags = local.tags
}
