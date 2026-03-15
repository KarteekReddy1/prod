provider "aws" {
  region = "us-east-1"  # Change as needed
}

locals {
  services = [
    "emailservice",
    "checkoutservice",
    "recommendationservice",
    "frontend",
    "paymentservice",
    "productcatalogservice",
    "cartservice",
    "loadgenerator",
    "currencyservice",
    "shippingservice",
    "adservice"
  ]
}

resource "aws_ecr_repository" "services" {
  for_each = toset(local.services)

  name = each.value

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  # ✅ This line tells AWS to delete all images before deleting the repo
  force_delete = true

  tags = {
    Environment = "production"
    Service     = each.value
  }
}


resource "aws_ecr_lifecycle_policy" "policy" {

  for_each = aws_ecr_repository.services

  repository = each.value.name

  policy = jsonencode({

    rules = [
  
      {
        rulePriority = 1
        description  = "Keep last 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
} 
