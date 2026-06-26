terraform {
  backend "s3" {
    bucket = "githubactions-eks-bucket"
    key    = "Prod/terraform.tfstate"
    region = "us-east-1"
  }
}