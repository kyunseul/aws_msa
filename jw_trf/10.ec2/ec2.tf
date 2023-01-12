resource "aws_instance" "bastion_a" {
  ami             = data.aws_ami.amazon_linux2.id #Amazon Linux 2 latest (ap-northeast-2)
  instance_type   = var.bastion_instance_type
  key_name        = data.terraform_remote_state.key.outputs.mykey
  security_groups = [data.terraform_remote_state.security.outputs.bastion_id]
  subnet_id       = data.terraform_remote_state.vpc.outputs.pub_a
  tags = {
    Name = "AWSb_bastion_a"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_instance" "bastion_c" {
  ami             = data.aws_ami.amazon_linux2.id #Amazon Linux 2 latest (ap-northeast-2)
  instance_type   = var.bastion_instance_type
  key_name        = data.terraform_remote_state.key.outputs.mykey
  security_groups = [data.terraform_remote_state.security.outputs.bastion_id]
  subnet_id       = data.terraform_remote_state.vpc.outputs.pub_c
  tags = {
    Name = "AWSb_bastion_c"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "mgmt_a" {
  ami                    = coalesce(var.image_id, data.aws_ami.amazon_linux2.id) #Amazon Linux 2 latest (ap-northeast-2)
  instance_type          = var.mgmt_instance_type
  vpc_security_group_ids = [data.terraform_remote_state.security.outputs.mgmt_id]
  user_data = templatefile("mgmt-userdata.tftpl", {
    user      = data.terraform_remote_state.user.outputs.user_name
    accesskey = data.terraform_remote_state.user.outputs.user_access_key
    secretkey = data.terraform_remote_state.user.outputs.user_secret_key
    /*mfa-access-key        = data.local_file.mfa-access.content
    mfa-secret-access-key = data.local_file.mfa-secret.content
    mfa-session-token     = data.local_file.mfa-session.content*/
    cluster-name = data.terraform_remote_state.eks.outputs.eks_name
  })
  key_name  = data.terraform_remote_state.key.outputs.mykey
  subnet_id = data.terraform_remote_state.vpc.outputs.mgmt_a
  #user_data_replace_on_change = true
  tags = {
    Name = "mgmt_a"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "mgmt_c" {
  ami                    = coalesce(var.image_id, data.aws_ami.amazon_linux2.id) #Amazon Linux 2 latest (ap-northeast-2)
  instance_type          = var.mgmt_instance_type
  vpc_security_group_ids = [data.terraform_remote_state.security.outputs.mgmt_id]
  user_data = templatefile("mgmt-userdata.tftpl", {
    user      = data.terraform_remote_state.user.outputs.user_name
    accesskey = data.terraform_remote_state.user.outputs.user_access_key
    secretkey = data.terraform_remote_state.user.outputs.user_secret_key
    /*mfa-access-key        = data.local_file.mfa-access.content
    mfa-secret-access-key = data.local_file.mfa-secret.content
    mfa-session-token     = data.local_file.mfa-session.content*/
    cluster-name = data.terraform_remote_state.eks.outputs.eks_name
  })
  key_name  = data.terraform_remote_state.key.outputs.mykey
  subnet_id = data.terraform_remote_state.vpc.outputs.mgmt_c
  #user_data_replace_on_change = true
  tags = {
    Name = "mgmt_c"
  }
  lifecycle {
    create_before_destroy = true
  }
}
# data_ami
data "aws_ami" "amazon_linux2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["amazon"] # Amazon Linux Owner
}

# #mfa-token-data
# data "local_file" "mfa-access" {
#   filename = "./mfa-access-key"
# }
# data "local_file" "mfa-secret" {
#   filename = "./mfa-secret-access-key"
# }
# data "local_file" "mfa-session" {
#   filename = "./mfa-session-token"
# }

resource "aws_instance" "jenkins_a" {
  ami             = data.aws_ami.amazon_linux2.id #Amazon Linux 2 latest (ap-northeast-2)
  instance_type   = var.instance_type_jenkins
  key_name        = data.terraform_remote_state.key.outputs.mykey
  security_groups = [data.terraform_remote_state.security.outputs.jenkins_id]
  subnet_id       = data.terraform_remote_state.vpc.outputs.mgmt_a
  user_data       = templatefile("jenkins-userdata.tftpl", { var = "a" })
  tags = {
    Name = "AWSb_jenkins_a"
  }
  lifecycle {
    create_before_destroy = true
  }
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 50
  }
}

resource "aws_instance" "jenkins_c" {
  ami             = data.aws_ami.amazon_linux2.id #Amazon Linux 2 latest (ap-northeast-2)
  instance_type   = var.instance_type_jenkins
  key_name        = data.terraform_remote_state.key.outputs.mykey
  security_groups = [data.terraform_remote_state.security.outputs.jenkins_id]
  subnet_id       = data.terraform_remote_state.vpc.outputs.mgmt_c
  user_data       = templatefile("jenkins-c-userdata.tftpl", { var = "c" })
  tags = {
    Name = "AWSb_jenkins_c"
  }
  lifecycle {
    create_before_destroy = true
  }
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 50
  }
}