variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "eks_cluster_name" {
  description = "Name of the EKS Cluster"
  default     = "kafka-eks-cluster"
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  default     = "1.25"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  default     = "dev"
}

variable "log_table_name" {
  description = "DynamoDB table for log storage"
  default     = "kafka_log_analysis"
}
