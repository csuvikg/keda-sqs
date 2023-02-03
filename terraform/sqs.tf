resource "aws_sqs_queue" "consumer_queue" {
  name = "consumer_queue.fifo"
  fifo_queue = true
  content_based_deduplication = true
  delay_seconds = 0
  receive_wait_time_seconds = 0
}

resource "aws_sqs_queue" "jobs_queue" {
  name = "jobs_queue.fifo"
  fifo_queue = true
  content_based_deduplication = true
  delay_seconds = 0
  receive_wait_time_seconds = 0
}

output "aws_sqs_consumer_queue_url" {
  value = aws_sqs_queue.consumer_queue.url
}

output "aws_sqs_jobs_queue_url" {
  value = aws_sqs_queue.jobs_queue.url
}
