output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}
