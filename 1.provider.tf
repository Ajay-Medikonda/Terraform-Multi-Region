provider "aws" {
  alias  = "east-1"
  region = var.aws_region1
}

provider "aws" {
  alias  = "east-2"
  region = var.aws_region2
}

terraform {
  required_version = "<= 1.6.0" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 6.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
}