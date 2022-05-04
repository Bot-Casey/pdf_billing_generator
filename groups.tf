resource "aws_iam_group" "inputbucketgroup" {
  name = "inputbucketgroup"
}

data "aws_iam_group" "inputbucketgroup" {
  group_name = aws_iam_group.inputbucketgroup.name
}

resource "aws_iam_group" "billing_sqs_queue" {
  name = "billing_sqs_queue"
}

data "aws_iam_group" "billing_sqs_queue" {
  group_name = aws_iam_group.billing_sqs_queue.name
}

resource "aws_iam_user_group_membership" "inputbucket" {
  for_each = toset( var.input_bucket_clients )

  user = aws_iam_user.input_bucket_clients[each.key].name
  groups = [
    data.aws_iam_group.inputbucketgroup.group_name,
    data.aws_iam_group.billing_sqs_queue.group_name
  ]
} 