module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version
  subnet_ids      = module.vpc.private_subnets  # Use `subnet_ids` instead of `subnets`
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_size         = 5
      min_size         = 2

      instance_type = "t3.medium"
      key_name      = var.key_name  # Optional, specify if you have SSH access key
    }
  }
}
