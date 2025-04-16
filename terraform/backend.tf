terraform {
  backend "s3" {
    bucket = "ky-s3-terraform"
    key    = "ky-terraform-asg3.6.tfstate"
    region = "us-east-1"
  }
}