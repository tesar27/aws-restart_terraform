resource "aws_s3_bucket" "files" {
  bucket_prefix = "aws-capstone-files-"
  force_destroy = true # convenient for dev (removes objects on destroy)

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [object_lock_configuration]
  }

  tags = {
    Name        = "files-bucket"
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket_acl" "files_acl" {
  bucket = aws_s3_bucket.files.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "files_versioning" {
  bucket = aws_s3_bucket.files.id

  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "files_sse" {
#   bucket = aws_s3_bucket.files.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

resource "aws_s3_bucket_public_access_block" "files_block" {
  bucket                  = aws_s3_bucket.files.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
