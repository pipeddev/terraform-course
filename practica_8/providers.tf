terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.95.0, <5.97.0, !=5.96.0"
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

