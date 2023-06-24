terraform {
  backend "s3" {
    bucket  = "trainingwebsite"
    key     = "website_ecs"
    region  = "eu-west-2"
    profile = "vscode"


  }
}