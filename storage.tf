resource "aws_s3_bucket" "files" {
  bucket_prefix = "aws-capstone-files-"
  acl           = "private"
  force_destroy = true # convenient for dev (removes objects on destroy)

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "files-bucket"
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket_public_access_block" "files_block" {
  bucket                  = aws_s3_bucket.files.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "files" {
  name         = "${terraform.workspace}-Files"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  range_key    = "fileId"

  attribute {
    name = "userId"
    type = "S"
  }
  attribute {
    name = "fileId"
    type = "S"
  }

  global_secondary_index {
    name            = "fileId-index"
    hash_key        = "fileId"
    projection_type = "ALL"
  }

  ttl {
    attribute_name = "expireAt"
    enabled        = false
  }

  tags = {
    Name        = "Files-table"
    Environment = terraform.workspace
  }
}

resource "aws_dynamodb_table" "users" {
  name         = "${terraform.workspace}-Users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name            = "email-index"
    hash_key        = "email"
    projection_type = "ALL"
  }

  tags = {
    Name        = "Users-table"
    Environment = terraform.workspace
  }
}