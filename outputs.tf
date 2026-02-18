output "files_bucket_name" {
  value = aws_s3_bucket.files.id
}

output "files_table_name" {
  value = aws_dynamodb_table.files.name
}