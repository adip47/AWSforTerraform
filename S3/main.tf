locals {
 
  service_name = "smsply"
  owner        = "AC"
 
}
 
 
locals {
  common_tags = {
 
    service = local.service_name
    owner   = local.owner
}
}
 
 
 
resource "aws_s3_bucket" "test-bucket-sm" {
        bucket = "test-bucket-sm-${var.env_name}"
        acl = "private"
        server_side_encryption_configuration {
         rule {
          apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
      }
    }
}
    tags = local.common_tags
}
resource "aws_s3_bucket" "test-bucket-sm-bkt" {
        bucket = "test-bucket-sm-bkt-${var.env_name}"
        acl = "private"
        server_side_encryption_configuration {
         rule {
          apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
      }
    }
  }
    tags = local.common_tags
}
