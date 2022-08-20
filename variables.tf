# AWS Provider

variable "aws_profile" {
  description = "AWS profile that will be used to create the infrastructure."
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS region where the infrastructure will be created."
  type        = string
  default     = "us-east-1"
}

# EKS
variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "tfm-eks"
}

variable "cluster_version" {
  description = "EKS cluster version."
  type        = string
  default     = "1.22"
}

variable "instance_type" {
  description = "EKS instance types."
  type        = string
  default     = "t2.micro"
}

variable "cluster_size" {
  description = "EKS cluster size."
  type        = number
  default     = 2
}

variable "userarn" {
  description = "User arn."
  type        = string
  default     = "arn:aws:iam::66666666666:user/user1"
}

variable "username" {
  description = "User name."
  type        = string
  default     = "jruedas"
}
