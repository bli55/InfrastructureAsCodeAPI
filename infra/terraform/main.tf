terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment after creating an S3 bucket for remote state.
  # Run once locally with local state, create the bucket, then migrate.
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "infastructure-as-code-api/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
