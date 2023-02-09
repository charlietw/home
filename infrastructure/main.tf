resource "aws_s3_bucket" "bucket" {
  bucket = "ubuntu-rpi-homeassistant-backups"
  tags = {
    ManagedBy        = "Terraform"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "versioning-bucket-config" {

  bucket = aws_s3_bucket.bucket.id

  rule {
    id = "expire-after-30-days"

    noncurrent_version_expiration {
      noncurrent_days = 7
      newer_noncurrent_versions = 5
    }

    status = "Enabled"
  }
}
