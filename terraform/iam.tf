resource "aws_iam_user" "this" {
  name = "sqs-user"
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.consumer_queue.arn,
      aws_sqs_queue.jobs_queue.arn
    ]
  }
}

resource "aws_iam_user_policy" "this" {
  name   = "SqsSendReceive"
  user   = aws_iam_user.this.name
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

output "aws_access_key_id" {
  value = aws_iam_access_key.this.id
}

output "aws_secret_access_key" {
  sensitive = true
  value     = aws_iam_access_key.this.secret
}
