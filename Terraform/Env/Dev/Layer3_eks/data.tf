data "terraform_remote_state" "vpc_data" {
  backend = "s3"
  config = {
    region         = "us-east-1"
    bucket         = "statestorage1234"
    dynamodb_table = "state-lock"
    key            = "sotatek/mytfstate/layer2.tfstate"
  }
}
data "terraform_remote_state" "private_subnets_data" {
  backend = "s3"
  config = {
    region         = "us-east-1"
    bucket         = "statestorage1234"
    dynamodb_table = "state-lock"
    key            = "sotatek/mytfstate/layer2.tfstate"
  }
}

output "output" {
  value = data.terraform_remote_state.vpc_data.outputs
}
