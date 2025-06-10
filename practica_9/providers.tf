terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.95.0, <5.97.0, !=5.96.0"
    }
     random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }

  required_version = "~>1.11.1"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}



