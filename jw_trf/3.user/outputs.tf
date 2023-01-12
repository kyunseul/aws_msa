output "user_name" {
  value = aws_iam_user.user.name
}

output "user_access_key" {
  value = aws_iam_access_key.key.id
}

output "user_secret_key" {
  value     = aws_iam_access_key.key.secret
  sensitive = true
}

output "sensitive_secretkey_hash" {
  value = nonsensitive(sha256(aws_iam_access_key.key.secret))
}
