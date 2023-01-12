resource "aws_iam_user" "user" {
  name = "AWSb-user"
  #   path = "/system/" # default:"/" - Path in which to create the user.

  #   tags = {
  #     tag-key = "tag-value"
  #   }
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "policy" {
  name = "awsb-policy"
  user = aws_iam_user.user.name

  /*  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "eks.amazonaws.com"
                }
            }
        }
    ]
}
EOF*/
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "null_resource" "change-user" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_iam_user_policy.policy]
  provisioner "local-exec" {
    on_failure  = fail
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        printf '[iamuser]\naws_access_key_id = %s\naws_secret_access_key = %s' $ACCESS $SECRET >> ~/.aws/credentials
        printf 'provider "aws" {
    region     = "ap-northeast-2"
    access_key = "%s"
    secret_key = "%s"
            
        }' $ACCESS $SECRET > ../8.eks/provider.tf
     EOT
    environment = {
      USER   = aws_iam_user.user.name
      ACCESS = aws_iam_access_key.key.id
      SECRET = aws_iam_access_key.key.secret
    }
  }
}