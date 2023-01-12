resource "aws_efs_file_system" "efs" {
  creation_token = "awsb-efs"
  encrypted      = true

  tags = {
    Name = "awsb-efs"
  }
}

resource "aws_efs_mount_target" "efs-target-a" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = data.terraform_remote_state.vpc.outputs.node_a
  security_groups = [data.terraform_remote_state.security.outputs.efs_id]
}

resource "aws_efs_mount_target" "efs-target-c" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = data.terraform_remote_state.vpc.outputs.node_c
  security_groups = [data.terraform_remote_state.security.outputs.efs_id]
}