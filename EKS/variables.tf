variable "kubernetes_version" {
  description = "kubernetes version"
  type        = string
}
variable "aws_region" {
  description = "aws region"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

