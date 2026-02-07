# 1. Ορίζουμε τον Provider (AWS)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
}

# 2. Δημιουργούμε το ECR Repository (Η αποθήκη των images)
resource "aws_ecr_repository" "resume_api" {
  name                 = "thanos-resume-api" # Το όνομα που θα έχει στην AWS
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# 3. Output για να πάρουμε το URL που θα στείλουμε το image
output "ecr_repository_url" {
  value = aws_ecr_repository.resume_api.repository_url
}