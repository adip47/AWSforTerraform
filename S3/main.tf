resource "aws_s3_bucket" "test-bucket-sm" {
        bucket = "test-bucket-sm-${var.env_name}"
        acl = "private"
}
resource "aws_s3_bucket" "test-bucket-sm-bkt" {
        bucket = "test-bucket-sm-bkt-${var.env_name}"
        acl = "private"
}
resource "aws_s3_bucket" "test-bucket-sm-bkt-test" {
        bucket = "test-bucket-sm-bkt--test-${var.env_name}"
        acl = "private"
}
