terraform {
  backend "s3" {
    bucket  = "<state bucket name>"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    encrypt = "true"
    profile = "<Profile>"
  }
}
