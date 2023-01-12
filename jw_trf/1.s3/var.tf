variable "s3_name" {
  description = "Name of your s3. don't duplicate"
  type        = string
}
variable "region" {
  description = "region"
  type        = string
  default     = "ap-northeast-2"
}