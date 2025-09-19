terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.64"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
    Project = "Jenkins-Deployment-Terraform"
    Environment = var.environment 
    ManagedBy = "terraform"
    }
  }
}