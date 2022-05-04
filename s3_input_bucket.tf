resource "aws_s3_bucket" "billing_input" {
  bucket = "cstadicktest1"

  tags = {
    Name = "Billing S3"
  }
}

resource "aws_s3_bucket_acl" "biller_acl" {
  bucket = aws_s3_bucket.billing_input.bucket
  acl    = "private"
}