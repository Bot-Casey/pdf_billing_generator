resource "aws_iam_user" "input_bucket_clients" {
  for_each = toset( var.input_bucket_clients )
  name = each.key
}

resource "aws_iam_access_key" "input_bucket_clients" {
  for_each = toset(var.input_bucket_clients)
  user = aws_iam_user.input_bucket_clients[each.key].name
}

resource "aws_secretsmanager_secret" "input_bucket_clients" {
  for_each = toset( var.input_bucket_clients )
  name = "${each.key}"
}

resource "aws_secretsmanager_secret_version" "init" {
  for_each = toset( var.input_bucket_clients )
  secret_id = "${aws_secretsmanager_secret.input_bucket_clients[each.key].id}"
  secret_string = jsonencode({
    "AccessKey" = "${aws_iam_access_key.input_bucket_clients[each.key].id}",
    "SecretAccessKey" = "${aws_iam_access_key.input_bucket_clients[each.key].secret}"
  })
}

output "usersGenerated" {
  value = aws_iam_user.input_bucket_clients
}

