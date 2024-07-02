terraform {
  backend "s3" {
    bucket = "terraform-eks-jenkins"
    key    = "s3/terraform.tfstate"
    region = "us-east-1"
  }
}
