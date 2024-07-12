provider "aws" {
  alias   = "useast1"
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.4.0"
    }
  }
  backend "s3" {
    bucket         = "statestorage1234"
    dynamodb_table = "state-lock"
    key            = "sotatek/mytfstate/layer3.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
