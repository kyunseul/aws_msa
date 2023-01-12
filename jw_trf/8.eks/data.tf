data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    bucket = "awsb-jw"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
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

data "terraform_remote_state" "role" {

  backend = "s3"
  config = {
    bucket = "awsb-jw"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-role/terraform.tfstate"
  }
}