terraform {
  backend "s3" {
    bucket  = "vreeti-terraform-state-bucket"
    key     = "devops.tfstate"
    region  = "us-west-2"
    profile = "devops"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "devops"
}