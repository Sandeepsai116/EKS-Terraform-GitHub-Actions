terraform {
  required_version = "~> 1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }

  # Configure the S3 backend for state storage
  backend "s3" {
    bucket         = "my-ews-baket1-sandeepkonakanchi"
    region         = "us-east-1"
    key            = "eks/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "Lock-Files"  # Enable state locking using the DynamoDB table
  }
}

provider "aws" {
  region = var.aws-region
}

resource "aws_dynamodb_table" "lock_files" {
  name         = "Lock-Files"
  billing_mode = "PAY_PER_REQUEST"

  # Define the attributes
  attribute {
    name = "lockID"
    type = "S"
  }

  # Define the key schema correctly using an array
  key_schema = [
    {
      attribute_name = "lockID"
      key_type       = "HASH"  # Primary key
    }
  ]

  # Optionally, add this to enable TTL (Time to Live) feature if desired
  # ttl {
  #   attribute_name = "ttl"  # Specify your TTL attribute
  #   enabled        = true    # Enable TTL
  # }
}


