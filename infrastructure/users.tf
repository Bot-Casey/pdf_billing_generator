resource "aws_iam_user" "billing_clients" {
  for_each = toset( var.billing_clients )
  name = each.key
}

resource "aws_iam_access_key" "billing_clients" {
  for_each = toset(var.billing_clients)
  user = aws_iam_user.billing_clients[each.key].name
}

# Create secret for each user containing their key pairs for retrieval purposes.
resource "aws_secretsmanager_secret" "billing_clients" {
  for_each = toset( var.billing_clients )
  name = "${each.key}"
}

resource "aws_secretsmanager_secret_version" "init" {
  for_each = toset( var.billing_clients )
  secret_id = "${aws_secretsmanager_secret.billing_clients[each.key].id}"
  secret_string = jsonencode({
    "AccessKey" = "${aws_iam_access_key.billing_clients[each.key].id}",
    "SecretAccessKey" = "${aws_iam_access_key.billing_clients[each.key].secret}"
  })
}

output "usersGenerated" {
  value = aws_iam_user.billing_clients
}
