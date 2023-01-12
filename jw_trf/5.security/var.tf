variable "eks_security_group_name" {
  description = "The name of the security group for the EKS"
  type        = string
  default     = "allow_all_traffic_eks"
}

variable "node_security_group_name" {
  description = "The name of the security group for the Node"
  type        = string
  default     = "allow_all_traffic_node"
}