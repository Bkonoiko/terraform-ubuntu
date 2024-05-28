provider "aws" {
  region = "us-east-1"
  profile = "tfuser"
  shared_config_files = ["~/.aws/credentials"]
}