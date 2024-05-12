resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucketname
}

resource "aws_s3_bucket_versioning" "s3_bucket_ver" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}