terraform {
  required_version = "1.5.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.45.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1" 
}

provider "archive" {}