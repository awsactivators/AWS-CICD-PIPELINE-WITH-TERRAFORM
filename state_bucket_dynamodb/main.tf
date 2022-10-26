terraform {
  required_version = ">= 0.12"
}


provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "bucket-name-here"
  acl           = "private"
  force_destroy = true

  tags = {
    Name        = "state-bucket"
    Environment = var.env_name
  }
}


#DynamoDB for locking the state file

resource "aws_dynamodb_table" "dynamodb-state-lock" {
  name           = "lock-statefile"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
   name = "LockID"
   type = "S"
  }
  tags = {
   "Name" = "Lock-Table"
  }
}
