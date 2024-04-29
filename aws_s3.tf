resource "aws_s3_bucket" "external" {
  bucket = var.external_location_name
}

resource "aws_s3_object" "user_home" {
  for_each = local.list_of_users
  bucket   = aws_s3_bucket.external.id
  key      = replace(each.key, "/[@.*]/", "_")
}

resource "aws_s3_bucket_versioning" "external" {
  bucket = aws_s3_bucket.external.id

  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "external" {
  bucket = aws_s3_bucket.external.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}