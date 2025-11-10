terraform {
  backend "s3" {
    bucket = "bhanudas-terraform-state-bucket"
    key    = "ha-aws-arch/terraform.tfstate"
    region = "us-east-2"
  }
}
