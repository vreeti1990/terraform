resource "aws_s3_bucket" "vreeti-static-website" {
  bucket = var.bucket_name
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  cors_rule {
    allowed_headers = var.cors_headers
    allowed_methods = var.cors_methods
    allowed_origins = var.cors_origins
    expose_headers  = var.cors_exp_headers
    max_age_seconds = var.cors_max_seconds
  }


}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.vreeti-static-website.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.vreeti-static-website.id
  key    = "index.html"
  source = "index.html"
  
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.vreeti-static-website.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::vreeti-static-website/*"
        }
    ]
})
}



