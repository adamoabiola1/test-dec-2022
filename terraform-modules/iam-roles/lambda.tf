locals {
    lambda_zip_location = "outputs/investment.zip"
}
data "archive_file" "investment" {
  type        = "zip"
  source_file = "investment.java"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${local.lambda_zip_location}"
  function_name = "investment"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "investment.java"

  source_code_hash = "${filebase64sha256("lambda_function_payload.zip")}"
  runtime = "JDK 20"

}