terraform {
  required_version = "~> 1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #  Lock version to avoid unexpected problems
      version = "4.31.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
  }
  backend "s3" {
    bucket         = "awsb-jw"
    key            = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-tfstate-lock-vpc"
    encrypt        = "true"
  }
}
provider "aws" {
  region  = "ap-northeast-2"
  profile = "mfa"
}
