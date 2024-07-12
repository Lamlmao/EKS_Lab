provider "aws" {
  alias   = "useast1"
  region  = "us-east-1"
  profile = ""
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
  }
}
