resource "aws_ecr_repository" "kafka_ecr_repo" {
  name                 = "${var.environment}-kafka"
  image_tag_mutability = "MUTABLE"
}

output "repository_url" {
  value = aws_ecr_repository.kafka_ecr_repo.repository_url
}
