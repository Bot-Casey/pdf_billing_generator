resource "aws_iam_policy" "billing_s3_role" {
  name = "billing_s3_role"
  description = "allows iam input_bucket_clients to access billing_input s3 bucket"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectRetention",
                "s3:DeleteObjectVersion",
                "s3:GetObjectVersionTagging",
                "s3:GetObjectAttributes",
                "s3:PutObjectLegalHold",
                "s3:GetObjectLegalHold",
                "s3:GetObjectVersionAttributes",
                "s3:GetObjectVersionTorrent",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:GetObjectTorrent",
                "s3:PutObjectRetention",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectTagging",
                "s3:GetObjectVersionForReplication",
                "s3:DeleteObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "${aws_s3_bucket.billing_input.arn}"
        }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "billing_s3_attachment" {
  group = aws_iam_group.inputbucketgroup.name
  policy_arn = aws_iam_policy.billing_s3_role.arn
}

resource "aws_iam_policy" "billing_sqs_queue" {
  name = "billing_sqs_queue"
  description = "allows iam input_bucket_clients to send SQS messages to billing_sqs_queue"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.billing_sqs_queue.arn}"
   }]
  })
}

resource "aws_iam_group_policy_attachment" "billing_sqs_attachment" {
  group = aws_iam_group.inputbucketgroup.name
  policy_arn = aws_iam_policy.billing_sqs_queue.arn
}