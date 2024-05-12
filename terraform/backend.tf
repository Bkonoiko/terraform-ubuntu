terraform {
  backend "s3" {
    bucket = "tfuser-bucket"
    key = "state-files/terraform.tfstate"
    region = "us-east-1"
    profile = "tfuser"

  }
}