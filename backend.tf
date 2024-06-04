terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }

  required_version = ">= 1.6.6"

  backend "s3" {
    bucket  = "onewonder-tfstate"
    region  = "ap-northeast-1"
    key     = "quicksight/dev/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}