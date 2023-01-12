data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    bucket = "awsb-jw"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "key" {

  backend = "s3"
  config = {
    bucket = "awsb-jw"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-key/terraform.tfstate"
  }
}

data "terraform_remote_state" "security" {

  backend = "s3"
  config = {
    bucket = "awsb-jw"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-security/terraform.tfstate"
  }
}

data "terraform_remote_state" "eks" {

  backend = "s3"
  config = {
    bucket = "awsb-jw"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-eks/terraform.tfstate"
  }
}

data "terraform_remote_state" "user" {

  backend = "s3"
  config = {
    bucket = "awsb-jw"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-user/terraform.tfstate"
  }
} 