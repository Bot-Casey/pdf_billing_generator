resource "aws_s3_bucket" "billing_input" {
  bucket = "somerandomstring123"

  tags = {
    Name = "Billing S3"
  }
}

resource "aws_s3_bucket_acl" "billing_acl" {
  bucket = aws_s3_bucket.billing_input.bucket
  acl    = "private"
}