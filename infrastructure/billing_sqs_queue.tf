resource "aws_sqs_queue" "billing_sqs_queue" {
  name                        = "billing_sqs_queue"
  sqs_managed_sse_enabled     = true
}