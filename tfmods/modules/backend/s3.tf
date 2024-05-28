resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucketname
  force_destroy = true
  
}

resource "aws_s3_bucket_versioning" "s3_bucket_ver" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.ver_stat
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_buck_encrypt" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = aws_kms_key.awskey.id
    }
  }
  depends_on = [ aws_kms_key.awskey ]
}

resource "aws_kms_key" "awskey" {
    key_usage = "ENCRYPT_DECRYPT"
  description = "key for s3 bucket  "
}

