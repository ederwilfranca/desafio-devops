provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./vpc.tf"
}

module "eks" {
  source = "./eks.tf"
}

module "rds" {
  source = "./rds.tf"
}

resource "aws_s3_bucket" "app_bucket" {
  source = "./s3.tf"
}

resource "aws_ecr_repository" "app_repo" {
  source = "./ecr.tf"
}

resource "aws_ebs_volume" "db_volume" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
}
