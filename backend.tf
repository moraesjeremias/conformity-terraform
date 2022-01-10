terraform {
  required_providers {
    conformity = {
      version = "0.3.6"
      source  = "trendmicro/conformity"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.71.0"
    }
  }
  backend "s3" {
  }
}

provider "conformity" {
  region = var.conformity_region
  apikey = var.conformity_apikey
}

provider "aws" {
  region = var.conformity_region
}