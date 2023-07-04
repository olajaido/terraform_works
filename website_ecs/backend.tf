terraform {
  backend "s3" {
    bucket  = "trainingwebsite"
    key     = "website_ecs/techmax/terraform.tfstate"
    region  = "eu-west-2"
    profile = "vscode"
 //   dynamodb_table = "terraform-state-lock"


  }
}