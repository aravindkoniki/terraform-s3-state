provider "aws" {
    region = "eu-west-1"
}

resource "aws_s3_bucket" "terrafrom-state" {
    bucket = "terraformstate-mydevaccount-05082023"
    
    lifecycle {
        prevent_destroy = true
    }

    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dynamodb_table" "terraform-locks" {
    name         = "terraformstate-locks-mydevaccount-05082023"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}