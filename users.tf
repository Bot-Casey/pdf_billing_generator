resource "aws_iam_user" "input_bucket_clients" {
  for_each = toset( var.input_bucket_clients )
  name = each.key
}

output "usersGenerated" {
  value = aws_iam_user.input_bucket_clients
}

