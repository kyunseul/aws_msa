# 서브넷그룹 : rds 생성했을 때 사용한 동일한 서브넷그룹 사용

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster

# 파라미터그룹 (ssl 비활성화 위해 생성)
resource "aws_docdb_cluster_parameter_group" "awsb-parameter-group" {
  family      = "docdb4.0"
  name        = "awsb-parameter-group"
  description = "docdb cluster parameter group"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}

#################################################### user-db 
# 클러스터 생성
resource "aws_docdb_cluster" "user-db" {
  cluster_identifier              = "awsb-sockshop-userdb"
  engine_version                  = "4.0.0"
  engine                          = "docdb"
  master_username                 = "AWSb"
  master_password                 = "awsbawsb"
  availability_zones              = ["ap-northeast-2a", "ap-northeast-2c"]
  db_subnet_group_name            = aws_db_subnet_group.awsb-db.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.awsb-parameter-group.id
  vpc_security_group_ids          = [data.terraform_remote_state.security.outputs.docdb_id]
  # kms_key_id           = true
  # backup_retention_period = 5
  # preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
}

# 인스턴스 타입
resource "aws_docdb_cluster_instance" "userdb" {
  count              = 2
  identifier         = "awsb-sockshop-userdb-${count.index}"
  cluster_identifier = aws_docdb_cluster.user-db.id
  instance_class     = var.docdb_type # "무료 평가판 사용 가능"
}

#################################################### carts-db 
# 클러스터 생성
resource "aws_docdb_cluster" "cart-db" {
  cluster_identifier              = "awsb-sockshop-cartdb"
  engine_version                  = "4.0.0"
  engine                          = "docdb"
  master_username                 = "AWSb"
  master_password                 = "awsbawsb"
  availability_zones              = ["ap-northeast-2a", "ap-northeast-2c"]
  db_subnet_group_name            = aws_db_subnet_group.awsb-db.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.awsb-parameter-group.id
  vpc_security_group_ids          = [data.terraform_remote_state.security.outputs.docdb_id]
  # kms_key_id           = true
  # backup_retention_period = 5
  # preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
}

# 인스턴스 타입
resource "aws_docdb_cluster_instance" "cartdb" {
  count              = 2
  identifier         = "awsb-sockshop-cartdb-${count.index}"
  cluster_identifier = aws_docdb_cluster.cart-db.id
  instance_class     = var.docdb_type # "무료 평가판 사용 가능"
}


# # 서브넷그룹
# resource "aws_docdb_subnet_group" "aws-docdb" {
#   name       = "awsb-docdb subnet group"
#   subnet_ids = [aws_subnet.pri_a_db.id, aws_subnet.pri_c_db.id]
#   tags = {
#     Name = "AWSb-DocDB-Subnet-Group"
#   }
# }

