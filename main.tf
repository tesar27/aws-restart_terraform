terraform {
  cloud {
    organization = "local-sandbox-org"
    workspaces {
      name = "aws-restart_terraform"
    }
  }
}

provider "aws" {
  region = "us-west-2"  # Replace with your region
}