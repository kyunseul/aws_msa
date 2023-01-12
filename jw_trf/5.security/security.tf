#bastion_security_group
resource "aws_security_group" "bastion" {
  name_prefix = "bastion"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # allow_ssh
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-Bastion-SG"
  }
}

#mgmt_security_group
resource "aws_security_group" "mgmt" {
  name_prefix = "mgmt"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # allow_ssh
  ingress {
    description     = "SSH from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-Bastion-SG"
  }
}

#db_security_group
resource "aws_security_group" "db" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_mysql_db"
  }
}
#docdb_security_group
# security_group.docdb
resource "aws_security_group" "docdb" {
  description = "Permit DocDB Access"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # inbound_docdb
  ingress {
    description = "SSH from VPC"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    # security_groups = [aws_security_group.bastion.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-docdb-SG"
  }
}

#eks_security_group
resource "aws_security_group" "eks" {
  name        = var.eks_security_group_name
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description     = "eks-security_groups"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.mgmt.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-EKS-SG"
  }
}
/*#NodeGroup_security_group
resource "aws_security_group" "node" {
  name        = var.node_security_group_name
  description = "Allow All traffic inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-NG-SG"
  }
}*/

#jenkins_security_group
resource "aws_security_group" "jenkins" {
  name_prefix = "jenkins"
  description = "Allow tcp inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # allow_tcp 8080
  ingress {
    description = "tcp from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow_tcp 22
  ingress {
    description = "tcp from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["218.235.89.82/32", "221.152.126.227/32", "218.235.89.129/32", "10.0.10.86/32"]
  }
  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-jenkins-SG"
  }
}

resource "aws_security_group" "alb" {
  name        = "AWSb-jenkins-alb-SG"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-ALB-SG"
  }
}

resource "aws_security_group" "efs" {
  name        = "AWSb-efs-SG"
  description = "EFS-SG"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.0.12.0/24", "10.0.22.0/24"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSb-EFS-SG"
  }
}
