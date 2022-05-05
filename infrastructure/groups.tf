resource "aws_iam_group" "billing_clients" {
  name = "billing_clients"
}

data "aws_iam_group" "billing_clients" {
  group_name = aws_iam_group.billing_clients.name
}

resource "aws_iam_user_group_membership" "billing_clients" {
  for_each = toset( var.billing_clients )

  user = aws_iam_user.billing_clients[each.key].name
  groups = [
    data.aws_iam_group.billing_clients.group_name
  ]
} 