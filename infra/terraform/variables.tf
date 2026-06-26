variable "aws_region" {
  description = "AWS region to deploy all resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix applied to every AWS resource name"
  type        = string
  default     = "infra-as-code-api"
}

variable "app_port" {
  description = "Port the .NET container listens on"
  type        = number
  default     = 8080
}

variable "task_cpu" {
  description = "ECS Fargate task CPU units (256 = 0.25 vCPU)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "ECS Fargate task memory in MiB"
  type        = number
  default     = 512
}

variable "allowed_cidr" {
  description = "Your public IP in CIDR notation (e.g. 1.2.3.4/32) — only this IP can reach the API"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token with repo admin permissions — pass via TF_VAR_github_token env var, never commit"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "GitHub username or organisation that owns the repository"
  type        = string
  default     = "bli55"
}

variable "github_repository" {
  description = "GitHub repository name"
  type        = string
  default     = "InfrastructureAsCodeAPI"
}
