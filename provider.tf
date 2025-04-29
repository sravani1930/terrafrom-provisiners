terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }

  
  backend "s3" {
     bucket = "devopsify-remote-bucket"
     key    = "provisioner"
     region = "us-east-1"
     dynamodb_table = "devopsify-locking"

  }
}

provider "aws" {
  region = "us-east-1"
}