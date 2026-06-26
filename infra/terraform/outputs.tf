output "alb_url" {
  description = "Public URL of the Application Load Balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "ecr_repository_url" {
  description = "ECR URL — used in the GitHub Actions deploy workflow"
  value       = aws_ecr_repository.app.repository_url
}

output "kms_key_arn" {
  description = "Paste this into .sops.yaml after terraform apply"
  value       = aws_kms_key.sops.arn
}

output "secret_name" {
  description = "Secrets Manager secret name — set as SECRET_NAME env var"
  value       = aws_secretsmanager_secret.app.name
}

output "github_actions_access_key_id" {
  description = "Add as AWS_ACCESS_KEY_ID in GitHub repository secrets"
  value       = aws_iam_access_key.github_actions.id
  sensitive   = true
}

output "github_actions_secret_access_key" {
  description = "Add as AWS_SECRET_ACCESS_KEY in GitHub repository secrets"
  value       = aws_iam_access_key.github_actions.secret
  sensitive   = true
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}
