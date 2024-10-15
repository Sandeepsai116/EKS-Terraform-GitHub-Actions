terraform {
  required_version = "~> 1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
  
  backend "s3" {
    bucket         = "my-ews-baket1-sandeepkonakanchi"
    region         = "us-east-1"
    key            = "eks/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "Lock-Files"  # This is for state locking, not a backend block
  }
}

provider "aws" {
  region = var.aws-region
}

resource "aws_dynamodb_table" "lock_files" {
  name         = "Lock-Files"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "lockID"
    type = "S"
  }
}
