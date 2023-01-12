# aws_db_subnet_group
resource "aws_db_subnet_group" "awsb-db" {
  name       = "awsb-db subnet group"
  subnet_ids = [data.terraform_remote_state.vpc.outputs.db_a, data.terraform_remote_state.vpc.outputs.db_c]
  tags = {
    Name = "AWSb-DB-Subnet-Group"
  }
}

# aws_db_instance
resource "aws_db_instance" "awsb-db" {
  identifier_prefix = "awsb"
  allocated_storage = 10
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = var.db_type
  multi_az          = true
  db_name           = "socksdb"          # "petclinic" # "black_friday"
  username          = "catalogue_user"   # "master" "black"
  password          = "default_password" # "password" "awsbfriday"
  # parameter_group_name = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.awsb-db.name
  vpc_security_group_ids = [data.terraform_remote_state.security.outputs.db_id]
}