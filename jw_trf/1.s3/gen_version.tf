resource "null_resource" "gen_backend" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.sleep]
  provisioner "local-exec" {
    when    = create
    command = "./gen_version.sh $reg"
    environment = {
      reg = var.region
      # ex:data= data.terraform_remote_state.net.outputs.sub-priv3
    }
  }
}

resource "null_resource" "sleep" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    when    = create
    command = "sleep 5"
  }
}


resource "null_resource" "eks-version" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.gen_backend]
  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = "sed '22,25d' ./generated/version-eks.tf > ../8.eks/version-eks.tf"
  }
}

#5.security/vpcdata.tf
resource "null_resource" "security-data" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.gen_backend]
  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
    bucket_name=$(cut -d : -f2 ./generated/version-ec2.tf | awk -F\" '{print $2}' | sed -n 15p)
    printf 'data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
  }
}' $bucket_name > ../5.security/vpcdata.tf
EOT

  }
}

#8.eks/data.tf
resource "null_resource" "eks-data" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.gen_backend]
  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
    bucket_name=$(cut -d : -f2 ./generated/version-ec2.tf | awk -F\" '{print $2}' | sed -n 15p)
    printf 'data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
  }
}


data "terraform_remote_state" "security" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-security/terraform.tfstate"
  }
}

data "terraform_remote_state" "role" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-role/terraform.tfstate"
  }
}' $bucket_name $bucket_name $bucket_name > ../8.eks/data.tf
EOT

  }
}

#9.db/data.tf
resource "null_resource" "db-data" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.gen_backend]
  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
    bucket_name=$(cut -d : -f2 ./generated/version-ec2.tf | awk -F\" '{print $2}' | sed -n 15p)
    printf 'data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "security" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-security/terraform.tfstate"
  }
}' $bucket_name $bucket_name > ../9.db/data.tf
EOT

  }
}

#10.ec2/data.tf
resource "null_resource" "ec2-data" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.gen_backend]
  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
    bucket_name=$(cut -d : -f2 ./generated/version-ec2.tf | awk -F\" '{print $2}' | sed -n 15p)
    printf 'data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "key" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-key/terraform.tfstate"
  }
}

data "terraform_remote_state" "security" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-security/terraform.tfstate"
  }
}

data "terraform_remote_state" "eks" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-eks/terraform.tfstate"
  }
}

data "terraform_remote_state" "user" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-user/terraform.tfstate"
  }
} ' $bucket_name $bucket_name $bucket_name $bucket_name $bucket_name > ../10.ec2/data.tf
EOT

  }
}

#11.efs/data.tf
resource "null_resource" "efs-data" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.gen_backend]
  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
    bucket_name=$(cut -d : -f2 ./generated/version-ec2.tf | awk -F\" '{print $2}' | sed -n 15p)
    printf 'data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "security" {

  backend = "s3"
  config = {
    bucket = "%s"
    region = data.aws_region.current.name
    key    = "terraform/terraform-tfstate-lock-security/terraform.tfstate"
  }
}' $bucket_name $bucket_name > ../11.efs/data.tf
EOT

  }
}