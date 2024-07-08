resource "aws_s3_bucket" "app_bucket" {
  bucket = "flask-app-bucket"
  acl    = "private"
}
