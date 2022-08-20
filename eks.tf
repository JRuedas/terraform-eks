module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = [var.instance_type]
  }

  eks_managed_node_groups = {
    my_group = {
      min_size     = var.cluster_size
      max_size     = var.cluster_size
      desired_size = var.cluster_size
      instance_types = [var.instance_type]
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = var.userarn
      username = var.username
      groups   = ["system:masters"]
    },
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}