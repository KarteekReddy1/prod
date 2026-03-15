terraform {

  backend "s3" {

    bucket         = "prodpro1"
    key            = "global/ecr/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true

  }
}
