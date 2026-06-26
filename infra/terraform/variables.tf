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
