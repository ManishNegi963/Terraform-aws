provider "aws" {
	region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket_rsc" {
	bucket = "terraform-mani-s3-bucket"
} 	


resource "aws_s3_bucket_lifecycle_configuration" "config_s3_rsc"{
rule {
    id      = "example-rule"
    status  = "Enabled"

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  bucket = aws_s3_bucket.demo_bucket_rsc.id
}




