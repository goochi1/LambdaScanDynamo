provider "aws" {
  profile = "<profile>"
  region  = "eu-west-1"
}

data "archive_file" "dynamo_zip" {
  type        = "zip"
  source_file = "${path.module}/source/dynamolambda.py"
  output_path = "${path.module}/source/dynamolambda.zip"
}

resource "aws_lambda_function" "dynamo" {
  filename         = "${path.module}/source/dynamolambda.zip"
  function_name    = "dynamo"
  role             = "${aws_iam_role.iam_role_for_dynamo.arn}"
  handler          = "dynamolambda.lambda_handler"
  source_code_hash = "${data.archive_file.dynamo_zip.output_base64sha256}"
  runtime          = "python2.7"
  memory_size      = "512"
  timeout          = "150"
  
  environment {
    bucket = "${aws_s3_bucket.b.id}"
    tabel = "tabel-name"
  }
}

resource "aws_iam_role" "iam_role_for_dynamo" {
  name               = "DynamodbScan"
  assume_role_policy = "${file("${path.module}/policies/LambdaAssume.pol")}"
}

resource "aws_iam_role_policy" "iam_role_policy_for_dynamo" {
  name   = "DynamodbScan"
  role   = "${aws_iam_role.iam_role_for_dynamo.id}"
  policy = "${file("${path.module}/policies/LambdaExecution.pol")}"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.b.id}"
  key    = "manifest.json"
  source = "source/manifest.json"
}