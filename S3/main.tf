resource "aws_s3_bucket" "terraform-eks-jenkins" {
  bucket = "terraform-eks-jenkins"
  # enable versioning so we can see the full revision history of our statefile
  versioning {
    enabled = true
  }

  tags = {
    Name        = "terraform-eks-jenkins"
    Environment = "Dev"
  }
}
