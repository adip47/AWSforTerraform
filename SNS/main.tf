resource "aws_sns_topic" "test-topic-sm" {
  name = "test-topic-sm-${var.env_name}"
}
