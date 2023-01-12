# bastion_type
variable "bastion_instance_type" {
  description = "The type of the instnace"
  type        = string
  default     = "t2.micro"
}

# mgmt_type
variable "mgmt_instance_type" {
  description = "The type of the instnace"
  type        = string
  default     = "t3.large"
}
# jenkins_type
variable "instance_type_jenkins" {
  description = "The type of the instnace"
  type        = string
  default     = "t3.large"
}

# ami
variable "image_id" {
  description = "The ID of the instance's image"
  type        = string
  default     = "" # Amazon Linux 2
}

# user
variable "user" {
  description = "aws configure user name"
  type        = string
  default     = "" # Amazon Linux 2
}
/*
# accesskey
variable "accesskey" {
  description = "aws configure user access key"
  type        = string
  default     = "" # Amazon Linux 2
}

# secret-access-key
variable "secretkey" {
  description = "aws configure user secret access key"
  type        = string
  default     = "" # Amazon Linux 2
}

# accesskey
variable "mfaarn" {
  description = "aws configure user mfa arn"
  type        = string
  default     = "" # Amazon Linux 2
}*/