#-------------project providers.tf file-------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

#2-This will be our default region. If you're using an IDE other than Cloud9, you will
# put your access_key and secret_key here, below region.
provider "aws" {
  region = "us-east-1"
}
