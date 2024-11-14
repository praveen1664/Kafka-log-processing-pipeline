provider "aws" {
  region = var.aws_region
}

# Load VPC configuration
module "vpc" {
  source = "./vpc"
}

# Load EKS cluster configuration
module "eks" {
  source = "./eks"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

# Load DynamoDB configuration
module "dynamodb" {
  source = "./dynamodb"
}

# Load ECR configuration
module "ecr" {
  source = "./ecr"
}
