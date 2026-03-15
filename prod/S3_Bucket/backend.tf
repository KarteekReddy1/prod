terraform {

  backend "s3" {

    bucket         = "prodpro1"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true

  }
}
