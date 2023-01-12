resource "aws_dynamodb_table" "s3" {
  name         = "terraform-tfstate-lock-s3"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "vpc" {
  name         = "terraform-tfstate-lock-vpc"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "security" {
  name         = "terraform-tfstate-lock-security"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "key" {
  name         = "terraform-tfstate-lock-key"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "ec2" {
  name         = "terraform-tfstate-lock-ec2"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "role" {
  name         = "terraform-tfstate-lock-role"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "eks" {
  name         = "terraform-tfstate-lock-eks"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "user" {
  name         = "terraform-tfstate-lock-user"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "db" {
  name         = "terraform-tfstate-lock-db"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "efs" {
  name         = "terraform-tfstate-lock-efs"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}